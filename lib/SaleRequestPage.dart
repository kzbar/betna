import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

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
  String? _district; // منطقة إسطنبول
  String? _rooms; // عدد الغرف
  bool _inResidenceComplex = false; // ضمن مجمع سكني؟
  String _occupancy = 'فارغ'; // حالة الإشغال
  bool _submitting = false;

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
    '1+0','1+1','2+1','3+1','4+1','5+1','2+2','3+2','4+2'
  ];

  final List<String> _occupancyStatuses = const [
    'فارغ', 'مؤجر', 'يسكنه المالك'
  ];

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
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);

    try {
      final data = {
        'district': _district,
        'neighborhood': _neighborhoodCtrl.text.trim(),
        'street': _streetCtrl.text.trim(),
        'rooms': _rooms,
        'totalAreaSqm': double.tryParse(_totalAreaCtrl.text.replaceAll(',', '.')),
        'floor': int.tryParse(_floorCtrl.text),
        'buildingAge': int.tryParse(_buildingAgeCtrl.text),
        'inResidenceComplex': _inResidenceComplex,
        'complexName': _inResidenceComplex ? _complexNameCtrl.text.trim() : null,
        'occupancy': _occupancy,
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

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال الطلب بنجاح، سنتواصل معك قريباً.')),
      );
      _formKey.currentState!.reset();
      setState(() {
        _district = null;
        _rooms = null;
        _inResidenceComplex = false;
        _occupancy = S.of(context).kempty;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذّر الإرسال: $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF0FDFA), Color(0xFFE0F2F1)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          S.of(context).kSaleRequestTextFieldDec,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade700),
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
                                      decoration:  InputDecoration(labelText: S.of(context).kSaleRequestTextField1),
                                      items: _districts
                                          .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                                          .toList(),
                                      onChanged: (v) => setState(() => _district = v),
                                      validator: (v) => v == null ? S.of(context).kSelect : null,
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _neighborhoodCtrl,
                                      decoration:  InputDecoration(labelText:S.of(context).kSaleRequestTextField2),
                                      validator: (v) => (v == null || v.trim().isEmpty) ? 'أدخل اسم الحي' : null,
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _streetCtrl,
                                      decoration:  InputDecoration(labelText:S.of(context).kSaleRequestTextField3),
                                      validator: (v) => (v == null || v.trim().isEmpty) ? 'أدخل الشارع' : null,
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    DropdownButtonFormField<String>(
                                      value: _rooms,
                                      decoration:  InputDecoration(labelText: S.of(context).kSaleRequestTextField4)
                                      ,
                                      items: _roomTypes
                                          .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                                          .toList(),
                                      onChanged: (v) => setState(() => _rooms = v),
                                      validator: (v) => v == null ? 'اختر عدد الغرف' : null,
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _totalAreaCtrl,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      decoration:  InputDecoration(labelText: S.of(context).kSaleRequestTextField5),
                                      validator: (v) {
                                        final parsed = double.tryParse((v ?? '').replaceAll(',', '.'));
                                        if (parsed == null || parsed <= 0) return 'أدخل مساحة صحيحة';
                                        return null;
                                      },
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _floorCtrl,
                                      keyboardType: TextInputType.number,
                                      decoration:  InputDecoration(labelText: S.of(context).kSaleRequestTextField6),
                                      validator: (v) {
                                        final parsed = int.tryParse(v ?? '');
                                        if (parsed == null) return 'أدخل رقماً صحيحاً';
                                        return null;
                                      },
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _buildingAgeCtrl,
                                      keyboardType: TextInputType.number,
                                      decoration:  InputDecoration(labelText: S.of(context).kSaleRequestTextField7),
                                      validator: (v) {
                                        final parsed = int.tryParse(v ?? '');
                                        if (parsed == null || parsed < 0) return 'أدخل رقماً صحيحاً';
                                        return null;
                                      },
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    SwitchListTileFormField(
                                      title:  Text(S.of(context).kSaleRequestTextField8),
                                      initialValue: _inResidenceComplex,
                                      onChanged: (v) => setState(() => _inResidenceComplex = v),
                                    ),
                                  ),
                                  if (_inResidenceComplex)
                                    _fieldSized(
                                      isWide,
                                      TextFormField(
                                        controller: _complexNameCtrl,
                                        decoration: const InputDecoration(labelText: 'اسم المجمع السكني'),
                                        validator: (v) {
                                          if (_inResidenceComplex && (v == null || v.trim().isEmpty)) {
                                            return 'أدخل اسم المجمع';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  _fieldSized(
                                    isWide,
                                    DropdownButtonFormField<String>(
                                      value: _occupancy,
                                      decoration:  InputDecoration(labelText: S.of(context).kSaleRequestTextField9),
                                      items: _occupancyStatuses.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                                      onChanged: (v) => setState(() => _occupancy = v ?? 'فارغ'),
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _priceCtrl,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      decoration:  InputDecoration(labelText: S.of(context).kSaleRequestTextField10),
                                      validator: (v) {
                                        final parsed = double.tryParse((v ?? '').replaceAll(',', '.'));
                                        if (parsed == null || parsed <= 0) return 'أدخل سعراً صحيحاً';
                                        return null;
                                      },
                                    ),
                                  ),
                                  // Contact Section Header
                                  SizedBox(
                                    width: isWide ? (constraints.maxWidth - 16) : double.infinity,
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 8, bottom: 4),
                                      child: Text('معلومات التواصل', style: TextStyle(fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _contactNameCtrl,
                                      decoration:  InputDecoration(labelText: S.of(context).kSaleRequestTextField11
                                      ),
                                      validator: (v) => (v == null || v.trim().isEmpty) ? 'أدخل الاسم' : null,
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _contactPhoneCtrl,
                                      keyboardType: TextInputType.phone,
                                      decoration:  InputDecoration(labelText: S.of(context).kSaleRequestTextField12),
                                      validator: (v) {
                                        final val = (v ?? '').trim();
                                        if (val.isEmpty) return 'أدخل رقم الهاتف';
                                        if (val.length < 7) return 'رقم غير صالح';
                                        return null;
                                      },
                                    ),
                                  ),
                                  _fieldSized(
                                    isWide,
                                    TextFormField(
                                      controller: _contactEmailCtrl,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration:  InputDecoration(labelText: S.of(context).kSaleRequestTextField13),
                                      validator: (v) {
                                        final val = (v ?? '').trim();
                                        if (val.isEmpty) return null;
                                        final emailRe = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                                        if (!emailRe.hasMatch(val)) return 'صيغة بريد غير صحيحة';
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        FilledButton.icon(
                          onPressed: _submitting ? null : _submit,
                          icon: _submitting
                              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.send),
                          label: Text(_submitting ? 'يتم الإرسال...' : 'إرسال الطلب'),
                          style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
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
    final width = isWide ?  (MediaQuery.of(context).size.width / 2) - 56 : double.infinity;
    return SizedBox(width: width, child: child);
  }
}

/// A minimal SwitchListTile as a FormField to integrate validation/layout with forms.
class SwitchListTileFormField extends FormField<bool> {
  SwitchListTileFormField({
    super.key,
    required Widget title,
    bool initialValue = false,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    ValueChanged<bool>? onChanged,
  }) : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    builder: (FormFieldState<bool> state) {
      return SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: title,
        value: state.value ?? false,
        onChanged: (v) {
          state.didChange(v);
          onChanged?.call(v);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );
    },
  );
}
