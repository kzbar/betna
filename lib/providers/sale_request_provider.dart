import 'dart:convert';
import 'dart:math';
import 'package:betna/generated/l10n.dart';
import 'package:betna/providers/istanbul_repository.dart';
import 'package:betna/utils/string_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum OccupancyStatus { vacant, rented, owner }

extension OccupancyStatusExtension on OccupancyStatus {
  String code() {
    switch (this) {
      case OccupancyStatus.vacant:
        return 'vacant';
      case OccupancyStatus.rented:
        return 'rented';
      case OccupancyStatus.owner:
        return 'owner';
    }
  }

  static OccupancyStatus fromCode(String? code) {
    switch (code) {
      case 'rented':
        return OccupancyStatus.rented;
      case 'owner':
        return OccupancyStatus.owner;
      case 'vacant':
      default:
        return OccupancyStatus.vacant;
    }
  }

  String label(BuildContext context) {
    final s = S.of(context);
    switch (this) {
      case OccupancyStatus.vacant:
        return s.occupancyVacant;
      case OccupancyStatus.rented:
        return s.occupancyRented;
      case OccupancyStatus.owner:
        return s.occupancyOwner;
    }
  }
}

enum VerificationMethod { phone, email }

enum VerificationState {
  onSending,
  onVerifying,
  onVerifyCompleted,
  onSendCompleted,
  none,
}

const String kVerificationFunctionUrl =
    'https://us-central1-betna-tr.cloudfunctions.net/sendVerificationCode';

class SaleRequestProvider extends ChangeNotifier {
  static const roomTypes = [
    '1+0',
    '1+1',
    '2+1',
    '3+1',
    '4+1',
    '5+1',
    '2+2',
    '3+2',
    '4+2',
    '5+2',
    '3+3',
    '4+3',
    '5+3',
    'villa',
    'other',
  ];

  static const floorsList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30+',
  ];

  static const agesList = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11-15',
    '15-20',
    '21-25',
    '26-30',
    '31+',
  ];

  bool _isLoadingMap = true;
  bool get isLoadingMap => _isLoadingMap;

  Map<String, List<String>> _neighborhoodsByDistrict = {};
  Map<String, List<String>> get neighborhoodsByDistrict =>
      _neighborhoodsByDistrict;

  String? _selectedDistrict;
  String? get selectedDistrict => _selectedDistrict;

  String? _selectedNeighborhood;
  String? get selectedNeighborhood => _selectedNeighborhood;

  VerificationMethod? _verificationMethod;
  VerificationMethod? get verificationMethod => _verificationMethod;

  VerificationState _state = VerificationState.none;
  VerificationState get state => _state;

  bool _isPhoneVerified = false;
  bool get isPhoneVerified => _isPhoneVerified;

  bool _isEmailVerified = false;
  bool get isEmailVerified => _isEmailVerified;

  bool _sendingCode = false;
  bool get sendingCode => _sendingCode;

  String? _phoneVerificationId;

  final Random _random = Random.secure();
  String _generatedEmailCode = '';

  void setSelectedDistrict(String? district) {
    _selectedDistrict = district;
    _selectedNeighborhood = null;
    notifyListeners();
  }

  void setSelectedNeighborhood(String? neighborhood) {
    _selectedNeighborhood = neighborhood;
    notifyListeners();
  }

  void setVerificationMethod(VerificationMethod? method) {
    _verificationMethod = method;
    _state = VerificationState.none;
    _isPhoneVerified = false;
    _isEmailVerified = false;
    _sendingCode = false;
    notifyListeners();
  }

  Future<void> loadData() async {
    _isLoadingMap = true;
    notifyListeners();
    try {
      _neighborhoodsByDistrict = await loadNeighborhoodsByDistrict();
    } catch (e) {
      debugPrint('Error loading neighborhoods: $e');
    } finally {
      _isLoadingMap = false;
      notifyListeners();
    }
  }

  // --- Email Verification Logic ---
  Future<String?> sendEmailCode(String email, String lang) async {
    if (email.isEmpty) return 'Email is empty';

    final fingerprintId = StringUtils.contactFingerprint(email);
    try {
      final existingDoc = await FirebaseFirestore.instance
          .collection('sale_requests')
          .doc(fingerprintId)
          .get();
      if (existingDoc.exists) return 'Already submitted';
    } catch (e) {
      return 'Error checking existing: $e';
    }

    _sendingCode = true;
    _state = VerificationState.onSending;
    notifyListeners();

    try {
      final code = 100000 + _random.nextInt(900000);
      _generatedEmailCode = code.toString();

      final body = jsonEncode({
        'channel': 'email',
        'to': email.toLowerCase(),
        'code': _generatedEmailCode,
        'lang': lang,
      });

      final res = await http.post(
        Uri.parse(kVerificationFunctionUrl),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (res.statusCode != 200) throw Exception('Failed to send email code');

      _state = VerificationState.onSendCompleted;
      notifyListeners();
      return null; // Success
    } catch (e) {
      _state = VerificationState.none;
      notifyListeners();
      return e.toString();
    } finally {
      _sendingCode = false;
      notifyListeners();
    }
  }

  Future<bool> verifyEmailCode(String code) async {
    if (code.trim() == _generatedEmailCode) {
      _isEmailVerified = true;
      _state = VerificationState.onVerifyCompleted;
      notifyListeners();
      return true;
    }
    return false;
  }

  // --- Phone Verification Logic ---
  Future<void> sendPhoneCode(String phoneWithCode) async {
    _sendingCode = true;
    _state = VerificationState.onSending;
    _isPhoneVerified = false;
    notifyListeners();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneWithCode,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          _state = verificationPhase(e);
          notifyListeners();
        },
        codeSent: (String verificationId, int? resendToken) {
          _phoneVerificationId = verificationId;
          _state = VerificationState.onSendCompleted;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _phoneVerificationId = verificationId;
        },
      );
    } finally {
      _sendingCode = false;
      notifyListeners();
    }
  }

  // Note: Local helper for error handling
  VerificationState verificationPhase(FirebaseAuthException e) {
    debugPrint('verificationFailed: ${e.code} ${e.message}');
    return VerificationState.none;
  }

  Future<String?> verifyPhoneCode(String smsCode) async {
    if (_phoneVerificationId == null) return 'No verification code sent';

    _state = VerificationState.onVerifying;
    notifyListeners();

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _phoneVerificationId!,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      _isPhoneVerified = true;
      _state = VerificationState.onVerifyCompleted;
      notifyListeners();
      return null;
    } catch (e) {
      _state = VerificationState.none;
      notifyListeners();
      return e.toString();
    }
  }

  // --- Submission Logic ---
  Future<String?> submitRequest({
    required String name,
    required String phone,
    required String email,
    required String street,
    required String rooms,
    required String totalArea,
    required String floor,
    required String age,
    required bool inResidenceComplex,
    required String? complexName,
    required OccupancyStatus occupancy,
    required String price,
  }) async {
    String primaryType;
    String primaryValue;

    if (_verificationMethod == VerificationMethod.phone) {
      if (!_isPhoneVerified) return 'Phone not verified';
      final phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
      if (phoneNumber == null) return 'No authenticated phone number found';
      primaryType = 'phone';
      primaryValue = phoneNumber;
    } else {
      if (!_isEmailVerified) return 'Email not verified';
      primaryType = 'email';
      primaryValue = email.trim().toLowerCase();
    }

    final fingerprintId = StringUtils.contactFingerprint(primaryValue);

    final data = {
      'district': _selectedDistrict,
      'neighborhood': _selectedNeighborhood,
      'street': street.trim(),
      'rooms': rooms,
      'totalAreaSqm': double.tryParse(totalArea.replaceAll(',', '.')),
      'floor': floor,
      'buildingAge': age,
      'inResidenceComplex': inResidenceComplex,
      'complexName': inResidenceComplex ? complexName?.trim() : null,
      'occupancy': occupancy.code(),
      'priceTry': double.tryParse(price.replaceAll(',', '.')),
      'contact': {
        'name': name.trim(),
        'phone': phone.trim(),
        'email': email.trim(),
      },
      'primaryContactType': primaryType,
      'primaryContactValue': primaryValue,
      'createdAt': FieldValue.serverTimestamp(),
      'source': 'web',
    };

    try {
      await FirebaseFirestore.instance
          .collection('sale_requests')
          .doc(fingerprintId)
          .set(data);
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }
}
