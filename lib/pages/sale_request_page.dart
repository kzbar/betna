import 'dart:convert';
import 'dart:math';

import 'package:betna/pages/betna_home_page.dart';
import 'package:betna/providers/country_provider.dart';
import 'package:betna/providers/istanbul_repository.dart';
import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/style.dart';
import 'package:betna/widgets/country_dropdown.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../generated/l10n.dart';

enum OccupancyStatus { vacant, rented, owner }

enum VerificationMethod { phone, email }

enum VerificationState {
  onSending,
  onVerifying,
  onVerifyCompleted,
  onSendCompleted,
  none
}

extension OccupancyStatusX on OccupancyStatus {
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

  // النص المترجم حسب اللغة الحالية
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

class SaleRequestPage extends StatelessWidget {
  const SaleRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RequestFormPage();
  }
}

TextStyle customStyle(MainProvider provider, double size, Color color,
    FontWeight weight, double height, double letterSpacing) {
  return provider.currentLang == Lang.AR
      ? GoogleFonts.alexandria(
          height: height,
          letterSpacing: letterSpacing,
          fontSize: size,
          color: color,
          fontWeight: weight,
        )
      : GoogleFonts.roboto(
          height: height,
          letterSpacing: letterSpacing,
          fontSize: size,
          color: color,
          fontWeight: weight,
        );
}

class RequestFormPage extends StatefulWidget {
  const RequestFormPage({super.key});

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers

  final TextEditingController _streetCtrl = TextEditingController();
  final TextEditingController _totalAreaCtrl = TextEditingController();
  final TextEditingController _floorCtrl = TextEditingController();
  final TextEditingController _buildingAgeCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _contactNameCtrl = TextEditingController();
  final TextEditingController _contactPhoneCtrl = TextEditingController();
  final TextEditingController _contactEmailCtrl = TextEditingController();
  final TextEditingController _complexNameCtrl = TextEditingController();
  final TextEditingController _codeInputCtrl = TextEditingController();
  final TextEditingController _phoneCodeCtrl = TextEditingController();
  final TextEditingController _emailCodeCtrl = TextEditingController();

  final apikey =
      "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";
  ConfirmationResult? _webConfirmationResult;

  bool _requestSubmitted = false;
  bool _isVerificationMethodComplete = false;

  // Phone Auth
  String? _phoneVerificationId;
  bool _isPhoneVerified = false;
  bool _isEmaileVerified = false;
  bool _sendingPhoneCode = false;
  bool _verifyingPhoneCode = false;

  // Email OTP
  bool _emailCodeSent = false;
  String _generatedEmailCode = '';
  bool _verifyingEmailCode = false;

  VerificationMethod? _verificationMethod;
  bool _submitting = false;
  final Random _random = Random.secure();
  String? _rooms; // عدد الغرف
  String? _floor;
  String? _age;

  bool _inResidenceComplex = false; // ضمن مجمع سكني؟
  Map<String, List<String>> _neighborhoodsByDistrict = {};
  bool _isLoadingMap = true;
  String? _selectedDistrict;
  String? _selectedNeighborhood;
  OccupancyStatus _occupancy = OccupancyStatus.vacant;
  VerificationState state = VerificationState.none;

  final List<String> _roomTypes = const [
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
    'other'
  ];
  final List<String> _floorsList = const[
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
  final List<String> _agesList = const[
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
    '31+'
  ];

  static const String kVerificationFunctionUrl =
      'https://us-central1-kira-contract.cloudfunctions.net/sendVerificationCode';

  @override
  void initState() {
    _loadNeighborhoodData();
    super.initState();
  }

  @override
  void dispose() {
    _streetCtrl.dispose();
    _totalAreaCtrl.dispose();
    _floorCtrl.dispose();
    _buildingAgeCtrl.dispose();
    _priceCtrl.dispose();
    _contactNameCtrl.dispose();
    _contactPhoneCtrl.dispose();
    _contactEmailCtrl.dispose();
    _complexNameCtrl.dispose();
    _codeInputCtrl.dispose();
    _phoneCodeCtrl.dispose();
    _emailCodeCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadNeighborhoodData() async {
    try {
      final map = await loadNeighborhoodsByDistrict();
      setState(() {
        _neighborhoodsByDistrict = map;
        _isLoadingMap = false;
      });
    } catch (e) {
      // You can show a snackbar or error widget
      setState(() {
        _isLoadingMap = false;
      });
    }
  }

  Future<void> _sendPhoneCodeWeb() async {
    final rawPhone = _contactPhoneCtrl.text.trim();
    final appProvider = Provider.of<MainProvider>(context, listen: false);
    if (rawPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                S.of(context).kSaleRequestTextVerificationPhoneMessage1,
                style: customStyle(
                    appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5))),
      );
      return;
    }
    setState(() {
      _sendingPhoneCode = true;
      _isPhoneVerified = false;
    });
    final phone = rawPhone; // أو استخدم normalizePhoneInternational لو تحب

    try {
      _webConfirmationResult =
          await FirebaseAuth.instance.signInWithPhoneNumber(phone);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            S.of(context).kSaleRequestTextVerificationPhoneMessage3,
            style: customStyle(
                appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
          )),
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('signInWithPhoneNumber error: ${e.code} ${e.message}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            '${S.of(context).kSaleRequestTextVerificationPhoneMessage2} $e',
            style: customStyle(
                appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
          )),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            '${S.of(context).kSaleRequestTextVerificationPhoneMessage10} $e}',
            style: customStyle(
                appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
          )),
        );
      }
    } finally {
      if (mounted) setState(() => _sendingPhoneCode = false);
    }
  }

  Future<void> _verifyPhoneCodeWeb() async {
    final appProvider = Provider.of<MainProvider>(context, listen: false);
    if (_webConfirmationResult == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          S.of(context).kSaleRequestTextVerificationPhoneMessage4,
          style: customStyle(
              appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
        )),
      );
      return;
    }

    final smsCode = _phoneCodeCtrl.text.trim();
    if (smsCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          S.of(context).kSaleRequestTextVerificationPhoneMessage5,
          style: customStyle(
              appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
        )),
      );
      return;
    }
    setState(() => _verifyingPhoneCode = true);
    try {
      final userCredential = await _webConfirmationResult!.confirm(smsCode);
      final user = userCredential.user;

      if (user?.phoneNumber != null) {
        if (!mounted) return;
        setState(() {
          _isPhoneVerified = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            S.of(context).kSaleRequestTextVerificationPhoneMessage6,
            style: customStyle(
                appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
          )),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            S.of(context).kSaleRequestTextVerificationPhoneMessage8,
            style: customStyle(
                appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
          )),
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('confirm error: ${e.code} ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          '${S.of(context).kSaleRequestTextVerificationPhoneMessage9} $e}',
          style: customStyle(
              appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
        )),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          '${S.of(context).kSaleRequestTextVerificationPhoneMessage10} $e}',
          style: customStyle(
              appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
        )),
      );
    } finally {
      if (mounted) setState(() => _verifyingPhoneCode = false);
    }
  }

  Future<void> _sendEmailCode() async {
    final email = _contactEmailCtrl.text.trim();
    final appProvider = Provider.of<MainProvider>(context, listen: false);

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              S.of(context).kSaleRequestTextVerificationEmailMessage1,
              style: customStyle(
                  appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
            )),
      );
      return;
    }

    final normalizedEmail = email.toLowerCase();
    final fingerprintId = contactFingerprint(normalizedEmail);

    try {
      final existingDoc = await FirebaseFirestore.instance
          .collection('sale_requests')
          .doc(fingerprintId)
          .get();

      if (existingDoc.exists) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                  S.of(context).kSaleRequestTextVerificationEmailMessage4,
                  style: customStyle(appProvider, 14, Colors.black,
                      FontWeight.w400, 1.5, 0.5))),
        );
        return;
      }
    } catch (e) {
      if (!mounted) return;
      // لو صار خطأ في القراءة من Firestore، نبّه المستخدم وانهِ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذّر التحقق من الطلبات السابقة: $e')),
      );
      return;
    }

    setState(() { _verifyingEmailCode = true;
    state = VerificationState.onSending;
    });

    try {
      final code = 100000 + _random.nextInt(900000);
      _generatedEmailCode = code.toString();
      if (!mounted) return;
      final appProvider = Provider.of<MainProvider>(context, listen: false);
      final normalizedLang = (appProvider.currentLang == Lang.AR ||
              appProvider.currentLang == Lang.TR)
          ? appProvider.kLang
          : 'en';
      final body = jsonEncode({
        'channel': 'email',
        'to': email.toLowerCase(),
        'code': _generatedEmailCode,
        'lang': normalizedLang,
      });

      final res = await http.post(
        Uri.parse(kVerificationFunctionUrl),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (res.statusCode != 200) {
        if (kDebugMode) {
          state = VerificationState.none;
          print(res.body);
        }
        throw Exception('Failed to send email code: ${res.body}');
      }

      setState(() { _emailCodeSent = true;
      state = VerificationState.onSendCompleted;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.white,
            content: Text(
                S.of(context).kSaleRequestTextVerificationEmailMessage2,
                style: customStyle(
                    appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5))),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        state = VerificationState.none;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.white,
            content: Text(
                S.of(context).kSaleRequestTextVerificationEmailMessage3,
                style: customStyle(
                    appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5))),
      );
    } finally {
      if (mounted) setState(() => _verifyingEmailCode = false);
    }
  }

  Future<void> _verifyEmailCode() async {

    if (!_emailCodeSent) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
            Text(S
                .of(context)
                .kSaleRequestTextVerificationMessage4)),
      );
      return;
    }
    if (_emailCodeCtrl.text.trim() != _generatedEmailCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
            Text(S.of(context).kSaleRequestTextVerificationMessage5)),
      );
      return;
    }
    setState(() {
      state = VerificationState.onVerifyCompleted;
      _isEmaileVerified = true;
      _isVerificationMethodComplete = true;
      _verifyingEmailCode = false;
    });
  }

  Future<void> _sendPhoneCode() async {
    final rawPhone = _contactPhoneCtrl.text.trim();
    final appProvider = Provider.of<MainProvider>(context, listen: false);
    if (rawPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                S.of(context).kSaleRequestTextVerificationPhoneMessage1,
                style: customStyle(
                    appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5))),
      );
      return;
    }
    final normalizedPhone = normalizePhoneInternational(rawPhone.toLowerCase());
    final countryProvider =
        Provider.of<CountryProvider>(context, listen: false);
    final phoneCode = countryProvider.selectedPhoneCode;
    final phoneWithCode = '$phoneCode$normalizedPhone';
    debugPrint(phoneWithCode);
    final fingerprintId = contactFingerprint(phoneWithCode);
    try {
      final existingDoc = await FirebaseFirestore.instance
          .collection('sale_requests')
          .doc(fingerprintId)
          .get();

      if (existingDoc.exists) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                  S.of(context).kSaleRequestTextVerificationEmailMessage4,
                  style: customStyle(appProvider, 14, Colors.black,
                      FontWeight.w400, 1.5, 0.5))),
        );
        return;
      }
    } catch (e) {
      if (!mounted) return;
      // لو صار خطأ في القراءة من Firestore، نبّه المستخدم وانهِ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذّر التحقق من الطلبات السابقة: $e')),
      );
      return;
    }
    setState(() {
      state = VerificationState.onSending;
      _sendingPhoneCode = true;
      _isPhoneVerified = false;
    });

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneWithCode,
        // يجب أن يكون بصيغة دولية +90..., +966..., إلخ
        verificationCompleted: (PhoneAuthCredential credential) async {
          // في الويب غالباً لن يحدث تلقائي، لكن نحتفظ به
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('verificationFailed: ${e.code} ${e.message}');
          setState(() {
            state = VerificationState.none;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              S.of(context).kSaleRequestTextVerificationPhoneMessage2,
              style: customStyle(
                  appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
            )),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _phoneVerificationId = verificationId;
            state = VerificationState.onSendCompleted;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              S.of(context).kSaleRequestTextVerificationPhoneMessage3,
              style: customStyle(
                  appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
            )),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _phoneVerificationId = verificationId;
        },
      );
    } finally {
      if (mounted) {
        setState(() {
          _sendingPhoneCode = false;
        });
      }
    }
  }

  Future<void> _verifyPhoneCode() async {
    final appProvider = Provider.of<MainProvider>(context, listen: false);
    if (_phoneVerificationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          S.of(context).kSaleRequestTextVerificationPhoneMessage4,
          style: customStyle(
              appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
        )),
      );
      return;
    }

    final smsCode = _phoneCodeCtrl.text.trim();
    if (smsCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          S.of(context).kSaleRequestTextVerificationPhoneMessage5,
          style: customStyle(
              appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
        )),
      );
      return;
    }
    if (!mounted) return;
    setState(() {
      state = VerificationState.onVerifying;
      _verifyingPhoneCode = true;
    });
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _phoneVerificationId!,
        smsCode: smsCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;
      setState(() {
        _isPhoneVerified = true;
        state = VerificationState.onVerifyCompleted;
        _isVerificationMethodComplete = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          S.of(context).kSaleRequestTextVerificationPhoneMessage6,
          style: customStyle(
              appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
        )),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        state = VerificationState.none;
      });
      debugPrint('verificationFailed: ${e.code} ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          '${S.of(context).kSaleRequestTextVerificationPhoneMessage7} $e',
          style: customStyle(
              appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
        )),
      );
    } finally {
      if (mounted) {
        setState(() {
          _verifyingPhoneCode = false;
        });
      }
    }
  }

  Future<void> _submit() async {
    // تحقق من صحة الفورم
    if (!_formKey.currentState!.validate()) return;

    // تحقق طريقة التحقق
    if (_verificationMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(S.of(context).kSaleRequestTextVerificationMessage1)),
      );
      return;
    }

    // تحقق من التوثيق حسب الطريقة
    late String primaryType;
    late String primaryValue;

    if (_verificationMethod == VerificationMethod.phone) {
      if (!_isPhoneVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(S.of(context).kSaleRequestTextVerificationMessage2)),
        );
        return;
      }
      final user = FirebaseAuth.instance.currentUser;
      if (user?.phoneNumber == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(S.of(context).kSaleRequestTextVerificationMessage3)),
        );
        return;
      }
      primaryType = 'phone';
      primaryValue = user!.phoneNumber!;
    } else {
      // email
      if (!_isEmaileVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(S.of(context).kSaleRequestTextVerificationMessage4)),
        );
        return;
      }
      primaryType = 'email';
      primaryValue = _contactEmailCtrl.text.trim().toLowerCase();
    }

    setState(() => _submitting = true);

    try {
      final fingerprintId = contactFingerprint(primaryValue);

      final data = {
        'district': _selectedDistrict,
        'neighborhood': _selectedNeighborhood,
        'street': _streetCtrl.text.trim(),
        'rooms': _rooms,
        'totalAreaSqm':
            double.tryParse(_totalAreaCtrl.text.replaceAll(',', '.')),
        'floor': int.tryParse(_floorCtrl.text),
        'buildingAge': int.tryParse(_buildingAgeCtrl.text),
        'inResidenceComplex': _inResidenceComplex,
        'complexName':
            _inResidenceComplex ? _complexNameCtrl.text.trim() : null,
        'occupancy': _occupancy.label(context),
        'priceTry': double.tryParse(_priceCtrl.text.replaceAll(',', '.')),
        'contact': {
          'name': _contactNameCtrl.text.trim(),
          'phone': _contactPhoneCtrl.text.trim(),
          'email': _contactEmailCtrl.text.trim(),
        },
        'primaryContactType': primaryType,
        'primaryContactValue': primaryValue,
        'createdAt': FieldValue.serverTimestamp(),
        'source': 'web',
      };

      await FirebaseFirestore.instance
          .collection('sale_requests')
          .doc(fingerprintId) // بصمة استناداً إلى الإيميل أو الهاتف
          .set(data);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(S.of(context).kSaleRequestTextVerificationMessage6)),
      );

      _formKey.currentState!.reset();
      _phoneCodeCtrl.clear();
      _emailCodeCtrl.clear();

      setState(() {
        _requestSubmitted = true;
        _verificationMethod = null;
        _isPhoneVerified = false;
        _emailCodeSent = false;
        _generatedEmailCode = '';
        // إعادة ضبط باقي المتغيّرات حسب مشروعك
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${S.of(context).kSaleRequestTextFieldSendRequestMessageFailed} $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  String normalizePhoneInternational(String raw) {
    if (raw.trim().isEmpty) return '';
    String cleaned = raw.trim();
    // 1) إذا بدأت بـ 00 حوّلها إلى +
    if (cleaned.startsWith('00')) {
      cleaned = cleaned.substring(2);
    }
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }
    // 2) إزالة كل شيء ما عدا الأرقام و +
    cleaned = cleaned.replaceAll(RegExp(r'[^0-9+]'), '');
    // 3) لو ما في + في البداية، أضف واحد

    // 4) تأكد أن + واحد فقط في البداية (لو المستخدم كتب ++ مثلاً)
    cleaned = cleaned.replaceFirst(RegExp(r'^\++'), '+');
    return cleaned;
  }

  String? validateInternationalPhone(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) {
      return S.of(context).kSaleRequestTextFieldErrorMessage13;
    }
    // إذا وصلنا هنا فهو مقبول
    return null;
  }

  String contactFingerprint(String value) {
    final bytes = utf8.encode(value.trim().toLowerCase());
    return sha256.convert(bytes).toString();
  }

  Widget? fieldPhone(bool isWide) {
    final theme = Theme.of(context);
    switch (state) {
      case VerificationState.onSending:
        return _fieldSized(
            isWide,
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  width: 18,
                  height: 18,
                )),
                SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2)),
                Expanded(
                    child: SizedBox(
                  width: 18,
                  height: 18,
                )),
              ],
            ));

      case VerificationState.onVerifying:
        return _fieldSized(
            isWide,
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  width: 18,
                  height: 18,
                )),
                SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2)),
                Expanded(
                    child: SizedBox(
                  width: 18,
                  height: 18,
                )),
              ],
            ));

      case VerificationState.onVerifyCompleted:
        return _fieldSized(
            isWide,
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  width: 18,
                  height: 18,
                )),

                Text(S.of(context).kSaleRequestTextVerificationOkPhone,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400)),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade600,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade200,
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  width: 18,
                  height: 18,
                )),
              ],
            ));
      case VerificationState.onSendCompleted:
        return _fieldSized(
            isWide,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _phoneCodeCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.w200),
                        floatingLabelStyle: theme.textTheme.bodyMedium
                            ?.copyWith(
                                fontSize: 14,
                                color: kPrimaryLight,
                                fontWeight: FontWeight.w600),
                        labelStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: FontSize.scale(context, 6),
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        labelText: S
                            .of(context)
                            .kSaleRequestTextVerificationFieldPhone),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Style.primaryColors)),
                  onPressed: _verifyPhoneCode,
                  child: Text(
                      S
                          .of(context)
                          .kSaleRequestTextVerificationFieldConfirmPhone,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: FontSize.scale(context, 6),
                          color: Colors.white,
                          fontWeight: FontWeight.w300)),
                ))
              ],
            ));
      case VerificationState.none:
        return _fieldSized(
            isWide,
            FilledButton(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Style.primaryColors)),
              onPressed: _sendPhoneCode,
              child: Text(
                  S.of(context).kSaleRequestTextVerificationSendCodePhone,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400)),
            ));
    }
  }

  Widget? fieldEmail(bool isWide) {
    final theme = Theme.of(context);
    switch (state) {
      case VerificationState.onSending:
        return _fieldSized(
            isWide,
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                    )),
                SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2)),
                Expanded(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                    )),
              ],
            ));

      case VerificationState.onVerifying:
        return _fieldSized(
            isWide,
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                    )),
                SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2)),
                Expanded(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                    )),
              ],
            ));

      case VerificationState.onVerifyCompleted:
        return _fieldSized(
            isWide,
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                    )),

                Text(
                  S.of(context)
                      .kSaleRequestTextVerificationOkEmail,
                  style: theme
                      .textTheme.bodyMedium
                      ?.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight:
                      FontWeight.w400),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade600,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade200,
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                Expanded(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                    )),
              ],
            ));
      case VerificationState.onSendCompleted:
        return _fieldSized(
            isWide,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _emailCodeCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.w200),
                        floatingLabelStyle: theme.textTheme.bodyMedium
                            ?.copyWith(
                            fontSize: 14,
                            color: kPrimaryLight,
                            fontWeight: FontWeight.w600),
                        labelStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: FontSize.scale(context, 6),
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        labelText: S
                            .of(context)
                            .kSaleRequestTextVerificationFieldMail),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor:
                          WidgetStateProperty.all(Style.primaryColors)),
                      onPressed: _verifyEmailCode,
                      child: Text(
                          S
                              .of(context)
                              .kSaleRequestTextVerificationFieldConfirmPhone,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: FontSize.scale(context, 6),
                              color: Colors.white,
                              fontWeight: FontWeight.w300)),
                    ))
              ],
            ));
      case VerificationState.none:
        return _fieldSized(
            isWide,
            FilledButton(
              style: ButtonStyle(
                  backgroundColor:
                  WidgetStateProperty.all(Style.primaryColors)),
              onPressed: _sendEmailCode,
              child: Text(
                  S.of(context).kSaleRequestTextVerificationSendCodeEmail,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400)),
            ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appProvider = Provider.of<MainProvider>(context);
    if (_isLoadingMap) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_neighborhoodsByDistrict.isEmpty) {
      return const Center(
        child: Text('No neighborhood data found'),
      );
    }
    final districts = _neighborhoodsByDistrict.keys.toList()..sort();
    final neighborhoods = _selectedDistrict == null
        ? <String>[]
        : (_neighborhoodsByDistrict[_selectedDistrict] ?? <String>[])
      ..sort();

    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        child: _requestSubmitted
            ? _SuccessView()
            : Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Style.primaryColors, const Color(0xFFE0F2F1)],
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      S.of(context).kSaleRequestTextFieldTitle,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                              fontSize: 28,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      S.of(context).kSaleRequestTextFieldDec,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(
                                              fontSize: 18,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 24),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        final isWide =
                                            constraints.maxWidth > 720;
                                        return Wrap(
                                          runSpacing: 16,
                                          spacing: 16,
                                          alignment: WrapAlignment.center,
                                          children: [
                                            _fieldSized(
                                              isWide,
                                              DropdownButtonFormField<String>(
                                                value: _selectedDistrict,
                                                decoration: InputDecoration(
                                                    errorStyle: theme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .w200),
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                kPrimaryLight,
                                                            fontWeight: FontWeight
                                                                .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight
                                                                .w400),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField1),
                                                items: districts
                                                    .map(
                                                        (d) => DropdownMenuItem(
                                                            value: d,
                                                            child: Text(
                                                              d,
                                                              style: customStyle(
                                                                  appProvider,
                                                                  12,
                                                                  Colors.grey
                                                                      .shade700,
                                                                  FontWeight
                                                                      .w500,
                                                                  1.5,
                                                                  0.5),
                                                            )))
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedDistrict = value;
                                                    _selectedNeighborhood =
                                                        null; // reset neighborhood
                                                  });
                                                },
                                                validator: (v) => v == null
                                                    ? S
                                                        .of(context)
                                                        .kSaleRequestTextFieldErrorMessage1
                                                    : null,
                                              ),
                                            ),
                                            _fieldSized(
                                              isWide,
                                              DropdownButtonFormField<String>(
                                                value: _selectedNeighborhood,
                                                decoration: InputDecoration(
                                                    errorStyle: theme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .w200),
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                kPrimaryLight,
                                                            fontWeight: FontWeight
                                                                .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight
                                                                .w400),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField2),
                                                items: neighborhoods
                                                    .map(
                                                        (d) => DropdownMenuItem(
                                                            value: d,
                                                            child: Text(
                                                              d,
                                                              style: customStyle(
                                                                  appProvider,
                                                                  12,
                                                                  Colors.grey
                                                                      .shade700,
                                                                  FontWeight
                                                                      .w500,
                                                                  1.5,
                                                                  0.5),
                                                            )))
                                                    .toList(),
                                                onChanged: neighborhoods.isEmpty
                                                    ? null
                                                    : (value) {
                                                        setState(() {
                                                          _selectedNeighborhood =
                                                              value;
                                                        });
                                                      },
                                                validator: (v) => v == null
                                                    ? S
                                                        .of(context)
                                                        .kSaleRequestTextFieldErrorMessage2
                                                    : null,
                                              ),
                                            ),

                                            _fieldSized(
                                              isWide,
                                              TextFormField(
                                                style: customStyle(
                                                    appProvider,
                                                    14,
                                                    Colors.black,
                                                    FontWeight.w400,
                                                    1.5,
                                                    0.5),
                                                controller: _streetCtrl,
                                                decoration: InputDecoration(
                                                    errorStyle: theme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .w200),
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                kPrimaryLight,
                                                            fontWeight: FontWeight
                                                                .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight
                                                                .w400),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField3),
                                                validator: (v) => (v == null ||
                                                        v.trim().isEmpty)
                                                    ? S
                                                        .of(context)
                                                        .kSaleRequestTextFieldErrorMessage3
                                                    : null,
                                              ),
                                            ),
                                            _fieldSized(
                                              isWide,
                                              DropdownButtonFormField<String>(
                                                value: _rooms,
                                                decoration: InputDecoration(
                                                    errorStyle: theme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .w200),
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                kPrimaryLight,
                                                            fontWeight: FontWeight
                                                                .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight
                                                                .w400),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField4),
                                                items: _roomTypes
                                                    .map((r) =>
                                                        DropdownMenuItem(
                                                            value: r,
                                                            child: Text(r)))
                                                    .toList(),
                                                onChanged: (v) =>
                                                    setState(() => _rooms = v),
                                                validator: (v) => v == null
                                                    ? S
                                                        .of(context)
                                                        .kSaleRequestTextFieldErrorMessage4
                                                    : null,
                                              ),
                                            ),

                                            _fieldSized(
                                              isWide,
                                              TextFormField(
                                                controller: _totalAreaCtrl,
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                        decimal: true),
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                decoration: InputDecoration(
                                                    errorStyle: theme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .w200),
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                kPrimaryLight,
                                                            fontWeight: FontWeight
                                                                .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight
                                                                .w400),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField5),
                                                validator: (v) {
                                                  final parsed =
                                                      double.tryParse((v ?? '')
                                                          .replaceAll(
                                                              ',', '.'));
                                                  if (parsed == null ||
                                                      parsed <= 0) {
                                                    return S
                                                        .of(context)
                                                        .kSaleRequestTextFieldErrorMessage5;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            _fieldSized(
                                              isWide,
                                              DropdownButtonFormField<String>(
                                                value: _floor,
                                                decoration: InputDecoration(
                                                    errorStyle: theme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                        fontSize: 10,
                                                        color: Colors.red,
                                                        fontWeight: FontWeight
                                                            .w200),
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        color:
                                                        kPrimaryLight,
                                                        fontWeight: FontWeight
                                                            .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField6),
                                                items: _floorsList
                                                    .map((r) =>
                                                    DropdownMenuItem(
                                                        value: r,
                                                        child: Text(r)))
                                                    .toList(),
                                                onChanged: (v) =>
                                                    setState(() => _floor = v),
                                                validator: (v) => v == null
                                                    ? S
                                                    .of(context)
                                                    .kSaleRequestTextFieldErrorMessage6
                                                    : null,
                                              ),
                                            ),
                                            _fieldSized(
                                              isWide,
                                              DropdownButtonFormField<String>(
                                                value: _age,
                                                decoration: InputDecoration(
                                                    errorStyle: theme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                        fontSize: 10,
                                                        color: Colors.red,
                                                        fontWeight: FontWeight
                                                            .w200),
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        color:
                                                        kPrimaryLight,
                                                        fontWeight: FontWeight
                                                            .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField7),
                                                items: _agesList
                                                    .map((r) =>
                                                    DropdownMenuItem(
                                                        value: r,
                                                        child: Text(r)))
                                                    .toList(),
                                                onChanged: (v) =>
                                                    setState(() => _age = v),
                                                validator: (v) => v == null
                                                    ? S
                                                    .of(context)
                                                    .kSaleRequestTextFieldErrorMessage7
                                                    : null,
                                              ),
                                            ),
                                            _fieldSized(
                                              isWide,
                                              SwitchListTileFormField(
                                                title: Text(
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                    S
                                                        .of(context)
                                                        .kSaleRequestTextField8),
                                                initialValue:
                                                    _inResidenceComplex,
                                                validator: (v) => v == null
                                                    ? S
                                                        .of(context)
                                                        .kSaleRequestTextFieldErrorMessage8
                                                    : null,
                                                onChanged: (v) => setState(() =>
                                                    _inResidenceComplex = v),
                                              ),
                                            ),
                                            if (_inResidenceComplex)
                                              _fieldSized(
                                                isWide,
                                                TextFormField(
                                                  controller: _complexNameCtrl,
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                  decoration: InputDecoration(
                                                      errorStyle: theme
                                                          .textTheme.bodySmall
                                                          ?.copyWith(
                                                              fontSize: 10,
                                                              color: Colors.red,
                                                              fontWeight: FontWeight
                                                                  .w200),
                                                      floatingLabelStyle: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              fontSize: 14,
                                                              color:
                                                                  kPrimaryLight,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                      labelStyle: theme.textTheme.bodyMedium?.copyWith(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      labelText: S
                                                          .of(context)
                                                          .kSaleRequestTextField9),
                                                  validator: (v) {
                                                    if (_inResidenceComplex &&
                                                        (v == null ||
                                                            v.trim().isEmpty)) {
                                                      return S
                                                          .of(context)
                                                          .kSaleRequestTextFieldErrorMessage9;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            _fieldSized(
                                              isWide,
                                              DropdownButtonFormField<
                                                  OccupancyStatus>(
                                                value: _occupancy,
                                                decoration: InputDecoration(
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                kPrimaryLight,
                                                            fontWeight: FontWeight
                                                                .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight
                                                                .w400),
                                                    errorStyle: theme.textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .w200),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField10),
                                                items: OccupancyStatus.values
                                                    .map((st) {
                                                  return DropdownMenuItem(
                                                    value: st,
                                                    child: Text(
                                                        st.label(context),
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                  );
                                                }).toList(),
                                                onChanged: (v) => setState(() =>
                                                    _occupancy = v ??
                                                        OccupancyStatus.vacant),
                                              ),
                                            ),
                                            _fieldSized(
                                              isWide,
                                              TextFormField(
                                                controller: _priceCtrl,
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                kPrimaryLight,
                                                            fontWeight: FontWeight
                                                                .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight
                                                                .w400),
                                                    errorStyle: theme.textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .w200),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField11),
                                                validator: (v) {
                                                  final parsed =
                                                      double.tryParse((v ?? '')
                                                          .replaceAll(
                                                              ',', '.'));
                                                  if (parsed == null ||
                                                      parsed <= 0) {
                                                    return S
                                                        .of(context)
                                                        .kSaleRequestTextFieldErrorMessage11;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            // Contact Section Header

                                            _fieldSized(
                                              isWide,
                                              SizedBox(
                                                width: isWide
                                                    ? (constraints.maxWidth -
                                                        16)
                                                    : double.infinity,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8, bottom: 4),
                                                  child: Text(
                                                      S
                                                          .of(context)
                                                          .kSaleRequestTextFieldContactInformation,
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                              ),
                                            ),
                                            _fieldSized(
                                              isWide,
                                              TextFormField(
                                                controller: _contactNameCtrl,
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                decoration: InputDecoration(
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                kPrimaryLight,
                                                            fontWeight: FontWeight
                                                                .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight
                                                                .w400),
                                                    errorStyle: theme.textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .w200),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField12),
                                                validator: (v) => (v == null ||
                                                        v.trim().isEmpty)
                                                    ? S
                                                        .of(context)
                                                        .kSaleRequestTextFieldErrorMessage12
                                                    : null,
                                              ),
                                            ),
                                            _fieldSized(
                                              isWide,
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 140,
                                                    child: CountryDropdown(),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                      child: TextFormField(
                                                    controller:
                                                        _contactPhoneCtrl,
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    decoration: InputDecoration(
                                                        errorStyle: theme
                                                            .textTheme.bodySmall
                                                            ?.copyWith(
                                                                fontSize: 10,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                        floatingLabelStyle: theme
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color:
                                                                    kPrimaryLight,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                        labelStyle: theme
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.black,
                                                                fontWeight: FontWeight.w400),
                                                        labelText: S.of(context).kSaleRequestTextField13),
                                                    validator:
                                                        validateInternationalPhone,
                                                  ))
                                                ],
                                              ),
                                            ),
                                            _fieldSized(
                                              isWide,
                                              TextFormField(
                                                controller: _contactEmailCtrl,
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                    floatingLabelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                kPrimaryLight,
                                                            fontWeight: FontWeight
                                                                .w600),
                                                    labelStyle: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight
                                                                .w400),
                                                    errorStyle: theme.textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: 10,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight
                                                                .w200),
                                                    labelText: S
                                                        .of(context)
                                                        .kSaleRequestTextField14),
                                                validator: (v) {
                                                  final val = (v ?? '').trim();
                                                  if (val.isEmpty) return null;
                                                  final emailRe = RegExp(
                                                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                                                  if (!emailRe.hasMatch(val)) {
                                                    return S
                                                        .of(context)
                                                        .kSaleRequestTextFieldErrorMessage14;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            if(!_isVerificationMethodComplete)...[
                                              _fieldSized(
                                                isWide,
                                                SizedBox(
                                                  width: constraints.maxWidth,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          S
                                                              .of(context)
                                                              .kSaleRequestTextVerificationTitle,
                                                          style: theme
                                                              .textTheme.bodyMedium
                                                              ?.copyWith(
                                                              fontSize: FontSize
                                                                  .scale(
                                                                  context,
                                                                  12),
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700)),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: RadioListTile<
                                                                VerificationMethod>(
                                                              title: Text(
                                                                S
                                                                    .of(context)
                                                                    .kSaleRequestTextVerificationMethod1,
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                    fontSize:
                                                                    FontSize.scale(
                                                                        context,
                                                                        8),
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                              ),
                                                              activeColor: Style
                                                                  .primaryColors,
                                                              value:
                                                              VerificationMethod
                                                                  .phone,
                                                              groupValue:
                                                              _verificationMethod,
                                                              onChanged: (v) =>
                                                                  setState(() =>
                                                                  _verificationMethod =
                                                                      v),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: RadioListTile<
                                                                VerificationMethod>(
                                                              title: Text(
                                                                S
                                                                    .of(context)
                                                                    .kSaleRequestTextVerificationMethod2,
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                    fontSize:
                                                                    FontSize.scale(
                                                                        context,
                                                                        8),
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                              ),
                                                              activeColor: Style
                                                                  .primaryColors,
                                                              value:
                                                              VerificationMethod
                                                                  .email,
                                                              groupValue:
                                                              _verificationMethod,
                                                              onChanged: (v) =>
                                                                  setState(() =>
                                                                  _verificationMethod =
                                                                      v),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                            if (_verificationMethod ==
                                                VerificationMethod.phone) ...[
                                              fieldPhone(isWide)!,
                                            ],
                                            if (_verificationMethod ==
                                                VerificationMethod.email) ...[
                                                  fieldEmail(isWide)!,
                                            ]
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    if(_isVerificationMethodComplete)
                                    FilledButton.icon(
                                      onPressed: _submitting ? null : _submit,
                                      style: FilledButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 6),
                                          backgroundColor: Style.primaryColors),
                                      icon: _submitting
                                          ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2))
                                          : Icon(Icons.send),
                                      label: Text(
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                        _submitting
                                            ? S
                                                .of(context)
                                                .kSaleRequestTextFieldSendRequestMessageSending
                                            : S
                                                .of(context)
                                                .kSaleRequestTextFieldSendRequest,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  // Helper to size fields nicely in a responsive grid-like layout
  Widget _fieldSized(bool isWide, Widget child) {
    final width =
        isWide ? (MediaQuery.of(context).size.width / 2) - 48 : double.infinity;
    return SizedBox(width: width, child: child);
  }
}

/// A minimal SwitchListTile as a FormField to integrate validation/layout with forms.
class SwitchListTileFormField extends FormField<bool> {
  SwitchListTileFormField({
    super.key,
    required Widget title,
    bool super.initialValue = false,
    super.onSaved,
    super.validator,
    ValueChanged<bool>? onChanged,
  }) : super(
          builder: (FormFieldState<bool> state) {
            return SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              title: title,
              activeColor: Style.primaryColors,
              value: state.value ?? false,
              onChanged: (v) {
                state.didChange(v);
                onChanged?.call(v);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            );
          },
        );
}

class _SuccessView extends StatelessWidget {
  const _SuccessView();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // أيقونة النجاح
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade600,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade200,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                S.of(context).kSaleRequestSuccessfulMessageTitle,
                style: customStyle(
                    appProvider, 18, Colors.black, FontWeight.w500, 1.5, 0.5),
              ),

              const SizedBox(height: 10),
              Text(
                S.of(context).kSaleRequestSuccessfulMessageTitle2,
                textAlign: TextAlign.center,
                style: customStyle(
                    appProvider, 16, Colors.black, FontWeight.w500, 1.5, 0.5),
              ),

              const SizedBox(height: 30),

              FilledButton(
                onPressed: () {
                  // إعادة الطلب الجديد
                  Navigator.of(context).popAndPushNamed(
                    "/",
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Style.primaryColors,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  S.of(context).kSaleRequestSuccessfulMessageButtonReturn,
                  style: customStyle(
                      appProvider, 16, Colors.white, FontWeight.w300, 1.5, 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
