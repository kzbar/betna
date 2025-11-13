import 'dart:convert';
import 'dart:math';

import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

enum OccupancyStatus { vacant, rented, owner }

enum VerificationMethod { phone, email }

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

class RequestFormPage extends StatefulWidget {
  const RequestFormPage({super.key});

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _neighborhoodCtrl = TextEditingController();
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

  //firebase functions:config:set sendgrid.key="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" sendgrid.from="info@betna.com"

  final apikey =
      "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";

  // Phone Auth
  String? _phoneVerificationId;
  bool _isPhoneVerified = false;
  bool _sendingPhoneCode = false;
  bool _verifyingPhoneCode = false;
  final TextEditingController _phoneCodeCtrl = TextEditingController();

  // Email OTP
  bool _emailCodeSent = false;
  String _generatedEmailCode = '';
  bool _verifyingEmailCode = false;
  final TextEditingController _emailCodeCtrl = TextEditingController();

  VerificationMethod? _verificationMethod;
  bool _submitting = false;

  bool _codeSent = false;
  String _generatedCode = '';
  final Random _random = Random.secure();

  String? _district; // منطقة إسطنبول
  String? _rooms; // عدد الغرف
  bool _inResidenceComplex = false; // ضمن مجمع سكني؟
  //String _occupancy = 'فارغ'; // حالة الإشغال

  OccupancyStatus _occupancy = OccupancyStatus.vacant;

  final List<String> _districts = const [
    'Adalar',
    'Arnavutköy',
    'Ataşehir',
    'Avcılar',
    'Bağcılar',
    'Bahçelievler',
    'Bakırköy',
    'Başakşehir',
    'Bayrampaşa',
    'Beşiktaş',
    'Beykoz',
    'Beylikdüzü',
    'Beyoğlu',
    'Büyükçekmece',
    'Çatalca',
    'Çekmeköy',
    'Esenler',
    'Esenyurt',
    'Eyüpsultan',
    'Fatih',
    'Gaziosmanpaşa',
    'Güngören',
    'Kadıköy',
    'Kağıthane',
    'Kartal',
    'Küçükçekmece',
    'Maltepe',
    'Pendik',
    'Sancaktepe',
    'Sarıyer',
    'Şile',
    'Şişli',
    'Sultanbeyli',
    'Sultangazi',
    'Tuzla',
    'Ümraniye',
    'Üsküdar',
    'Zeytinburnu'
  ];

  final List<String> _roomTypes = const [
    '1+0',
    '1+1',
    '2+1',
    '3+1',
    '4+1',
    '5+1',
    '2+2',
    '3+2',
    '4+2'
  ];
  static const String kVerificationFunctionUrl =
      'https://us-central1-kira-contract.cloudfunctions.net/sendVerificationCode';

  @override
  void dispose() {
    _neighborhoodCtrl.dispose();
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                  S.of(context).kSaleRequestTextVerificationEmailMessage4,
                  style: customStyle(
                      appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5))),
        );
        return;
      }
    } catch (e) {
      // لو صار خطأ في القراءة من Firestore، نبّه المستخدم وانهِ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذّر التحقق من الطلبات السابقة: $e')),
      );
      return;
    }

    setState(() => _verifyingEmailCode = true);

    try {
      final code = 100000 + _random.nextInt(900000);
      _generatedEmailCode = code.toString();
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
          print(res.body);
        }
        throw Exception('Failed to send email code: ${res.body}');
      }

      setState(() => _emailCodeSent = true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.white,
            content: Text(
                S.of(context).kSaleRequestTextVerificationEmailMessage2,
                style: customStyle(
                    appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5))),
      );
    } catch (e) {
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

  Future<void> _sendPhoneCode() async {
    final rawPhone = _contactPhoneCtrl.text.trim();
    if (rawPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل رقم الهاتف أولاً.')),
      );
      return;
    }

    setState(() {
      _sendingPhoneCode = true;
      _isPhoneVerified = false;
    });

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: rawPhone,
        // يجب أن يكون بصيغة دولية +90..., +966..., إلخ
        verificationCompleted: (PhoneAuthCredential credential) async {
          // في الويب غالباً لن يحدث تلقائي، لكن نحتفظ به
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل إرسال SMS: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _phoneVerificationId = verificationId;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('تم إرسال كود SMS، أدخله ثم اضغط "تأكيد الهاتف".')),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _phoneVerificationId = verificationId;
        },
      );
    } finally {
      if (mounted) setState(() => _sendingPhoneCode = false);
    }
  }

  Future<void> _verifyPhoneCode() async {
    if (_phoneVerificationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أرسل كود SMS أولاً.')),
      );
      return;
    }

    final smsCode = _phoneCodeCtrl.text.trim();
    if (smsCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل كود SMS.')),
      );
      return;
    }
    setState(() => _verifyingPhoneCode = true);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _phoneVerificationId!,
        smsCode: smsCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;
      setState(() {
        _isPhoneVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم التحقق من رقم الهاتف بنجاح.')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('كود SMS غير صحيح: ${e.message}')),
      );
    } finally {
      if (mounted) setState(() => _verifyingPhoneCode = false);
    }
  }

  Future<void> _submit() async {
    // تحقق من صحة الفورم
    if (!_formKey.currentState!.validate()) return;

    // تحقق طريقة التحقق
    if (_verificationMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('اختر طريقة التحقق (هاتف أو بريد إلكتروني).')),
      );
      return;
    }

    // تحقق من التوثيق حسب الطريقة
    late String primaryType;
    late String primaryValue;

    if (_verificationMethod == VerificationMethod.phone) {
      if (!_isPhoneVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('يرجى تأكيد رقم الهاتف قبل إرسال الطلب.')),
        );
        return;
      }
      final user = FirebaseAuth.instance.currentUser;
      if (user?.phoneNumber == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تعذّر قراءة رقم الهاتف الموثّق.')),
        );
        return;
      }
      primaryType = 'phone';
      primaryValue = user!.phoneNumber!;
    } else {
      // email
      if (!_emailCodeSent) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('أرسل كود التحقق إلى الإيميل أولاً.')),
        );
        return;
      }
      if (_emailCodeCtrl.text.trim() != _generatedEmailCode) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('كود الإيميل غير صحيح.')),
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
        'district': _district,
        'neighborhood': _neighborhoodCtrl.text.trim(),
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
        const SnackBar(content: Text('تم إرسال الطلب بعد التحقق بنجاح.')),
      );

      _formKey.currentState!.reset();
      _phoneCodeCtrl.clear();
      _emailCodeCtrl.clear();

      setState(() {
        _verificationMethod = null;
        _isPhoneVerified = false;
        _emailCodeSent = false;
        _generatedEmailCode = '';
        // إعادة ضبط باقي المتغيّرات حسب مشروعك
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذّر إرسال الطلب: $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _submit1() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);

    try {
      final data = {
        'district': _district,
        'neighborhood': _neighborhoodCtrl.text.trim(),
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
        'createdAt': FieldValue.serverTimestamp(),
        'source': 'web',
      };

      //await FirebaseFirestore.instance.collection('sale_requests').add(data);
      _formKey.currentState!.reset();
      if (!mounted) return;
      final appProvider = Provider.of<MainProvider>(context, listen: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              S.of(context).kSaleRequestTextFieldSendRequestMessageSuccessfully,
              style: customStyle(
                  appProvider, 14, Colors.black, FontWeight.w400, 1.5, 0.5),
            )),
      );

      setState(() {
        _district = null;
        _rooms = null;
        _inResidenceComplex = false;
        _occupancy = OccupancyStatus.vacant;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      final appProvider = Provider.of<MainProvider>(context, listen: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            "${S.of(context).kSaleRequestTextFieldSendRequestMessageFailed}$e",
            style: customStyle(
                appProvider, 14, Colors.red, FontWeight.w400, 1.5, 0.5),
          ),
        ),
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
      cleaned = '+${cleaned.substring(2)}';
    }
    // 2) إزالة كل شيء ما عدا الأرقام و +
    cleaned = cleaned.replaceAll(RegExp(r'[^0-9+]'), '');
    // 3) لو ما في + في البداية، أضف واحد
    if (!cleaned.startsWith('+')) {
      cleaned = '+$cleaned';
    }
    // 4) تأكد أن + واحد فقط في البداية (لو المستخدم كتب ++ مثلاً)
    cleaned = cleaned.replaceFirst(RegExp(r'^\++'), '+');
    return cleaned;
  }

  String? validateInternationalPhone(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) {
      return S.of(context).kSaleRequestTextFieldErrorMessage13;
    }
    final normalized = normalizePhoneInternational(raw);
    // يجب أن يبدأ بـ +
    if (!normalized.startsWith('+')) {
      return 'يجب أن يكون الرقم بصيغة دولية ويبدأ بـ +';
    }
    // فقط + والأرقام
    if (!RegExp(r'^\+[0-9]+$').hasMatch(normalized)) {
      return 'الرقم يحتوي على رموز غير مسموح بها';
    }
    // طول تقريبي معقول لأرقام دولية
    if (normalized.length < 8 || normalized.length > 16) {
      return 'طول رقم الهاتف غير منطقي';
    }
    // إذا وصلنا هنا فهو مقبول
    return null;
  }

  TextStyle customStyle(MainProvider provider, double size, Color color,
      FontWeight weight, double height, double letterSpacing) {
    return provider.currentLang == Lang.AR
        ? GoogleFonts.changa(
            height: height,
            letterSpacing: letterSpacing,
            fontSize: size,
            color: color,
            fontWeight: weight,
          )
        : GoogleFonts.cambay(
            height: height,
            letterSpacing: letterSpacing,
            fontSize: size,
            color: color,
            fontWeight: weight,
          );
  }

  String contactFingerprint(String value) {
    final bytes = utf8.encode(value.trim().toLowerCase());
    return sha256.convert(bytes).toString();
  }

  Future<void> _startVerificationStep() async {
    // تأكد أن الحقول الأساسية سليمة
    if (!_formKey.currentState!.validate()) return;
    if (_verificationMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('اختر طريقة التحقق (هاتف أو بريد إلكتروني).')),
      );
      return;
    }
    String destination;
    if (_verificationMethod == VerificationMethod.phone) {
      final phone = _contactPhoneCtrl.text.trim();
      if (phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(S.of(context).kSaleRequestTextFieldErrorMessage13)),
        );
        return;
      }
      destination = normalizePhoneInternational(phone);
    } else {
      final email = _contactEmailCtrl.text.trim();
      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(S.of(context).kSaleRequestTextFieldErrorMessage14)),
        );
        return;
      }
      destination = email.toLowerCase();
    }
    // توليد كود 6 أرقام
    final code = 100000 + _random.nextInt(900000);
    _generatedCode = code.toString();
    // هنا مكان إرسال الكود فعليًا
    // TODO: replace this with your backend (Cloud Function / API)
    await sendVerificationCode(
      method: _verificationMethod!,
      destination: destination,
      code: _generatedCode,
    );

    // للتجربة فقط: عرض الكود (احذفها في الإنتاج)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('تم إرسال كود التحقق: $_generatedCode (للاختبار فقط)')),
    );
    setState(() {
      _codeSent = true;
    });
  }

  Future<void> sendVerificationCode({
    required VerificationMethod method,
    required String destination,
    required String code,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      body: Container(
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
              constraints: const BoxConstraints(maxWidth: 980),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          S.of(context).kSaleRequestTextFieldTitle,
                          textAlign: TextAlign.center,
                          style: customStyle(appProvider, 28, Colors.black,
                              FontWeight.w700, 1.2, 0.5),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          S.of(context).kSaleRequestTextFieldDec,
                          textAlign: TextAlign.center,
                          style: customStyle(appProvider, 16,
                              Colors.grey.shade700, FontWeight.w700, 1.5, 0.5),
                        ),
                        const SizedBox(height: 24),
                        Form(
                          key: _formKey,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final isWide = constraints.maxWidth > 720;
                              return Wrap(
                                runSpacing: 16,
                                spacing: 16,
                                alignment: WrapAlignment.center,
                                children: [
                                  _fieldSized(
                                    isWide,
                                    DropdownButtonFormField<String>(
                                      value: _district,
                                      decoration: InputDecoration(
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          labelText: S
                                              .of(context)
                                              .kSaleRequestTextField1),
                                      items: _districts
                                          .map((d) => DropdownMenuItem(
                                              value: d,
                                              child: Text(
                                                d,
                                                style: customStyle(
                                                    appProvider,
                                                    12,
                                                    Colors.grey.shade700,
                                                    FontWeight.w500,
                                                    1.5,
                                                    0.5),
                                              )))
                                          .toList(),
                                      onChanged: (v) =>
                                          setState(() => _district = v),
                                      validator: (v) => v == null
                                          ? S
                                              .of(context)
                                              .kSaleRequestTextFieldErrorMessage1
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
                                      controller: _neighborhoodCtrl,
                                      decoration: InputDecoration(
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          labelText: S
                                              .of(context)
                                              .kSaleRequestTextField2),
                                      validator: (v) => (v == null ||
                                              v.trim().isEmpty)
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
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
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
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          labelText: S
                                              .of(context)
                                              .kSaleRequestTextField4),
                                      items: _roomTypes
                                          .map((r) => DropdownMenuItem(
                                              value: r, child: Text(r)))
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
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      style: customStyle(
                                          appProvider,
                                          14,
                                          Colors.black,
                                          FontWeight.w400,
                                          1.5,
                                          0.5),
                                      decoration: InputDecoration(
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          labelText: S
                                              .of(context)
                                              .kSaleRequestTextField5),
                                      validator: (v) {
                                        final parsed = double.tryParse(
                                            (v ?? '').replaceAll(',', '.'));
                                        if (parsed == null || parsed <= 0) {
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
                                    TextFormField(
                                      controller: _floorCtrl,
                                      keyboardType: TextInputType.number,
                                      style: customStyle(
                                          appProvider,
                                          14,
                                          Colors.black,
                                          FontWeight.w400,
                                          1.5,
                                          0.5),
                                      decoration: InputDecoration(
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          labelText: S
                                              .of(context)
                                              .kSaleRequestTextField6),
                                      validator: (v) {
                                        final parsed = int.tryParse(v ?? '');
                                        if (parsed == null) {
                                          return S
                                              .of(context)
                                              .kSaleRequestTextFieldErrorMessage6;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _buildingAgeCtrl,
                                      keyboardType: TextInputType.number,
                                      style: customStyle(
                                          appProvider,
                                          14,
                                          Colors.black,
                                          FontWeight.w400,
                                          1.5,
                                          0.5),
                                      decoration: InputDecoration(
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          labelText: S
                                              .of(context)
                                              .kSaleRequestTextField7),
                                      validator: (v) {
                                        final parsed = int.tryParse(v ?? '');
                                        if (parsed == null || parsed < 0) {
                                          return S
                                              .of(context)
                                              .kSaleRequestTextFieldErrorMessage7;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    SwitchListTileFormField(
                                      title: Text(
                                          style: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          S.of(context).kSaleRequestTextField8),
                                      initialValue: _inResidenceComplex,
                                      validator: (v) => v == null
                                          ? S
                                              .of(context)
                                              .kSaleRequestTextFieldErrorMessage8
                                          : null,
                                      onChanged: (v) => setState(
                                          () => _inResidenceComplex = v),
                                    ),
                                  ),
                                  if (_inResidenceComplex)
                                    _fieldSized(
                                      isWide,
                                      TextFormField(
                                        controller: _complexNameCtrl,
                                        style: customStyle(
                                            appProvider,
                                            14,
                                            Colors.black,
                                            FontWeight.w400,
                                            1.5,
                                            0.5),
                                        decoration: InputDecoration(
                                            errorStyle: customStyle(
                                                appProvider,
                                                12,
                                                Colors.red,
                                                FontWeight.w300,
                                                1.5,
                                                0.5),
                                            labelStyle: customStyle(
                                                appProvider,
                                                14,
                                                Colors.black,
                                                FontWeight.w500,
                                                1.5,
                                                0.5),
                                            labelText: S
                                                .of(context)
                                                .kSaleRequestTextField9),
                                        validator: (v) {
                                          if (_inResidenceComplex &&
                                              (v == null || v.trim().isEmpty)) {
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
                                    DropdownButtonFormField<OccupancyStatus>(
                                      value: _occupancy,
                                      decoration: InputDecoration(
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
                                          labelText: S
                                              .of(context)
                                              .kSaleRequestTextField10),
                                      items: OccupancyStatus.values.map((st) {
                                        return DropdownMenuItem(
                                          value: st,
                                          child: Text(st.label(context),
                                              style: customStyle(
                                                  appProvider,
                                                  12,
                                                  Colors.grey.shade700,
                                                  FontWeight.w500,
                                                  1.5,
                                                  0.5)),
                                        );
                                      }).toList(),
                                      onChanged: (v) => setState(() =>
                                          _occupancy =
                                              v ?? OccupancyStatus.vacant),
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _priceCtrl,
                                      style: customStyle(
                                          appProvider,
                                          14,
                                          Colors.black,
                                          FontWeight.w400,
                                          1.5,
                                          0.5),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: InputDecoration(
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
                                          labelText: S
                                              .of(context)
                                              .kSaleRequestTextField11),
                                      validator: (v) {
                                        final parsed = double.tryParse(
                                            (v ?? '').replaceAll(',', '.'));
                                        if (parsed == null || parsed <= 0) {
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
                                          ? (constraints.maxWidth - 16)
                                          : double.infinity,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 8, bottom: 4),
                                        child: Text(
                                            S
                                                .of(context)
                                                .kSaleRequestTextFieldContactInformation,
                                            style: customStyle(
                                                appProvider,
                                                14,
                                                Colors.black,
                                                FontWeight.w800,
                                                1.5,
                                                0.5)),
                                      ),
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _contactNameCtrl,
                                      style: customStyle(
                                          appProvider,
                                          14,
                                          Colors.black,
                                          FontWeight.w400,
                                          1.5,
                                          0.5),
                                      decoration: InputDecoration(
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
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
                                    TextFormField(
                                      controller: _contactPhoneCtrl,
                                      style: customStyle(
                                          appProvider,
                                          14,
                                          Colors.black,
                                          FontWeight.w400,
                                          1.5,
                                          0.5),
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          labelText: S
                                              .of(context)
                                              .kSaleRequestTextField13),
                                      validator: validateInternationalPhone,
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _contactEmailCtrl,
                                      style: customStyle(
                                          appProvider,
                                          14,
                                          Colors.black,
                                          FontWeight.w400,
                                          1.5,
                                          0.5),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          labelStyle: customStyle(
                                              appProvider,
                                              14,
                                              Colors.black,
                                              FontWeight.w500,
                                              1.5,
                                              0.5),
                                          errorStyle: customStyle(
                                              appProvider,
                                              12,
                                              Colors.red,
                                              FontWeight.w300,
                                              1.5,
                                              0.5),
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
                                              style: customStyle(
                                                  appProvider,
                                                  14,
                                                  Colors.black,
                                                  FontWeight.w800,
                                                  1.5,
                                                  0.5)),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: RadioListTile<
                                                    VerificationMethod>(
                                                  title: Text(
                                                    S
                                                        .of(context)
                                                        .kSaleRequestTextVerificationMethod1,
                                                    style: customStyle(
                                                        appProvider,
                                                        14,
                                                        Colors.black,
                                                        FontWeight.w400,
                                                        1.5,
                                                        0.5),
                                                  ),
                                                  activeColor:
                                                      Style.primaryColors,
                                                  value:
                                                      VerificationMethod.phone,
                                                  groupValue:
                                                      _verificationMethod,
                                                  onChanged: (v) => setState(
                                                      () =>
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
                                                    style: customStyle(
                                                        appProvider,
                                                        14,
                                                        Colors.black,
                                                        FontWeight.w400,
                                                        1.5,
                                                        0.5),
                                                  ),
                                                  activeColor:
                                                      Style.primaryColors,
                                                  value:
                                                      VerificationMethod.email,
                                                  groupValue:
                                                      _verificationMethod,
                                                  onChanged: (v) => setState(
                                                      () =>
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
                                  if (_verificationMethod ==
                                      VerificationMethod.phone) ...[
                                    _fieldSized(
                                      isWide,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _phoneCodeCtrl,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  labelText: 'كود SMS'),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          OutlinedButton(
                                            onPressed: _sendingPhoneCode
                                                ? null
                                                : _sendPhoneCode,
                                            child: _sendingPhoneCode
                                                ? const SizedBox(
                                                    width: 18,
                                                    height: 18,
                                                    child:
                                                        CircularProgressIndicator(
                                                            strokeWidth: 2))
                                                : const Text('إرسال كود SMS'),
                                          ),
                                          const SizedBox(width: 8),
                                          FilledButton(
                                            onPressed: _verifyingPhoneCode
                                                ? null
                                                : _verifyPhoneCode,
                                            child: _verifyingPhoneCode
                                                ? const SizedBox(
                                                    width: 18,
                                                    height: 18,
                                                    child:
                                                        CircularProgressIndicator(
                                                            strokeWidth: 2))
                                                : const Text('تأكيد الهاتف'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (_isPhoneVerified)
                                      const Text('✅ تم التحقق من رقم الهاتف',
                                          style:
                                              TextStyle(color: Colors.green)),
                                  ],
                                  if (_verificationMethod ==
                                      VerificationMethod.email) ...[
                                    _fieldSized(
                                      isWide,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _emailCodeCtrl,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'كود التحقق (إيميل)'),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          OutlinedButton(
                                            onPressed: _verifyingEmailCode
                                                ? null
                                                : _sendEmailCode,
                                            child: _verifyingEmailCode
                                                ? const SizedBox(
                                                    width: 18,
                                                    height: 18,
                                                    child:
                                                        CircularProgressIndicator(
                                                            strokeWidth: 2))
                                                : const Text('إرسال الكود'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2))
                              : Icon(Icons.send),
                          label: Text(
                            style: customStyle(appProvider, 14, Colors.white,
                                FontWeight.w400, 1.5, 0.5),
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
        isWide ? (MediaQuery.of(context).size.width / 2) - 56 : double.infinity;
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
