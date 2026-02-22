import 'package:betna/generated/l10n.dart';
import 'package:betna/providers/sale_request_provider.dart';
import 'package:betna/style/style.dart';
import 'package:betna/widgets/sale_request/address_section.dart';
import 'package:betna/widgets/sale_request/contact_info_section.dart';
import 'package:betna/widgets/sale_request/property_details_section.dart';
import 'package:betna/widgets/sale_request/verification_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleRequestPage extends StatelessWidget {
  const SaleRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RequestFormPage();
  }
}

class RequestFormPage extends StatefulWidget {
  const RequestFormPage({super.key});

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _streetCtrl = TextEditingController();
  final _totalAreaCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _complexNameCtrl = TextEditingController();
  final _contactNameCtrl = TextEditingController();
  final _contactPhoneCtrl = TextEditingController();
  final _contactEmailCtrl = TextEditingController();
  final _phoneCodeCtrl = TextEditingController();
  final _emailCodeCtrl = TextEditingController();

  String? _rooms;
  String? _floor;
  String? _age;
  bool _inResidenceComplex = false;
  OccupancyStatus _occupancy = OccupancyStatus.vacant;
  bool _submitting = false;
  bool _success = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SaleRequestProvider>(context, listen: false).loadData();
    });
  }

  @override
  void dispose() {
    _streetCtrl.dispose();
    _totalAreaCtrl.dispose();
    _priceCtrl.dispose();
    _complexNameCtrl.dispose();
    _contactNameCtrl.dispose();
    _contactPhoneCtrl.dispose();
    _contactEmailCtrl.dispose();
    _phoneCodeCtrl.dispose();
    _emailCodeCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<SaleRequestProvider>(context, listen: false);

    setState(() => _submitting = true);
    final error = await provider.submitRequest(
      name: _contactNameCtrl.text,
      phone: _contactPhoneCtrl.text,
      email: _contactEmailCtrl.text,
      street: _streetCtrl.text,
      rooms: _rooms ?? '',
      totalArea: _totalAreaCtrl.text,
      floor: _floor ?? '',
      age: _age ?? '',
      inResidenceComplex: _inResidenceComplex,
      complexName: _complexNameCtrl.text,
      occupancy: _occupancy,
      price: _priceCtrl.text,
    );

    if (mounted) {
      setState(() => _submitting = false);
      if (error == null) {
        setState(() => _success = true);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final provider = Provider.of<SaleRequestProvider>(context);
    final isWide = MediaQuery.of(context).size.width > 900;

    if (_success) return const _SuccessView();

    return Scaffold(
      backgroundColor: Style.luxuryCharcoal,
      appBar: AppBar(
        title: Text(
          s.kBetnaHomePageSlide1Badge,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        elevation: 0,
        backgroundColor: Style.luxuryCharcoal,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.06),
          ),
        ),
      ),
      body: provider.isLoadingMap
          ? Center(child: CircularProgressIndicator(color: Style.primaryMaroon))
          : SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 48 : 24,
                      vertical: 32,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Hero header
                          _buildHeader(context, s, isWide),
                          const SizedBox(height: 32),

                          // EIDS Warning Banner
                          _buildEidsBanner(context, s),
                          const SizedBox(height: 40),

                          // Address Section
                          _buildSectionTitle(
                            context,
                            Icons.location_on_outlined,
                            s.kSaleRequestTextField1,
                          ),
                          const SizedBox(height: 20),
                          AddressSection(
                            isWide: isWide,
                            streetController: _streetCtrl,
                          ),
                          _buildDivider(),

                          // Property Details Section
                          _buildSectionTitle(
                            context,
                            Icons.home_outlined,
                            s.kSaleRequestTextField4,
                          ),
                          const SizedBox(height: 20),
                          PropertyDetailsSection(
                            isWide: isWide,
                            totalAreaController: _totalAreaCtrl,
                            priceController: _priceCtrl,
                            complexNameController: _complexNameCtrl,
                            rooms: _rooms,
                            floor: _floor,
                            age: _age,
                            inResidenceComplex: _inResidenceComplex,
                            occupancy: _occupancy,
                            onRoomsChanged: (v) => setState(() => _rooms = v),
                            onFloorChanged: (v) => setState(() => _floor = v),
                            onAgeChanged: (v) => setState(() => _age = v),
                            onComplexChanged: (v) =>
                                setState(() => _inResidenceComplex = v),
                            onOccupancyChanged: (v) =>
                                setState(() => _occupancy = v),
                          ),
                          _buildDivider(),

                          // Contact Info Section
                          _buildSectionTitle(
                            context,
                            Icons.person_outline,
                            s.kSaleRequestTextField12,
                          ),
                          const SizedBox(height: 20),
                          ContactInfoSection(
                            isWide: isWide,
                            nameController: _contactNameCtrl,
                            phoneController: _contactPhoneCtrl,
                            emailController: _contactEmailCtrl,
                          ),
                          _buildDivider(),

                          // Verification Section
                          _buildSectionTitle(
                            context,
                            Icons.verified_outlined,
                            s.kSaleRequestTextVerificationSend,
                          ),
                          const SizedBox(height: 20),
                          VerificationSection(
                            isWide: isWide,
                            phoneCodeController: _phoneCodeCtrl,
                            emailCodeController: _emailCodeCtrl,
                            phoneNumber: _contactPhoneCtrl.text,
                            email: _contactEmailCtrl.text,
                          ),
                          const SizedBox(height: 48),

                          // Submit Button
                          Center(
                            child: _submitting
                                ? CircularProgressIndicator(
                                    color: Style.primaryMaroon,
                                  )
                                : SizedBox(
                                    width: isWide ? 320 : double.infinity,
                                    height: 54,
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Style.primaryMaroon,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: Corners.medBorder,
                                        ),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1,
                                            ),
                                      ),
                                      onPressed: _submit,
                                      child: Text(
                                        s.kSaleRequestTextVerificationSend
                                            .toUpperCase(),
                                      ),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 48),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildHeader(BuildContext context, S s, bool isWide) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Style.primaryMaroon.withValues(alpha: 0.1),
            borderRadius: Corners.medBorder,
            border: Border.all(
              color: Style.primaryMaroon.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            s.kBetnaHomePageSlide1Badge.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Style.primaryMaroon,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          s.kBetnaHomePageSlide1Badge,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontSize: isWide ? 36 : 24,
            fontWeight: FontWeight.w900,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Style.primaryMaroon,
                Style.primaryMaroon.withValues(alpha: 0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildEidsBanner(BuildContext context, S s) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/eids'),
      borderRadius: Corners.smBorder,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: Style.primaryMaroon.withValues(alpha: 0.06),
          borderRadius: Corners.smBorder,
          border: Border.all(
            color: Style.primaryMaroon.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Style.primaryMaroon,
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.kEidsPageWarning,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    s.kEidsPageQuestion,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              color: Style.primaryMaroon.withValues(alpha: 0.6),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Style.primaryMaroon.withValues(alpha: 0.08),
            borderRadius: Corners.smBorder,
          ),
          child: Icon(icon, color: Style.primaryMaroon, size: 18),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Container(height: 1, color: Colors.white.withValues(alpha: 0.06)),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.luxuryCharcoal,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B5E20).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF66BB6A),
                  size: 80,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                S.of(context).kSaleRequestSuccessfulMessageTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                S.of(context).kSaleRequestSuccessfulMessageTitle2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 220,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Style.primaryMaroon,
                    side: BorderSide(
                      color: Style.primaryMaroon.withValues(alpha: 0.5),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: Corners.medBorder,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    S.of(context).kSaleRequestSuccessfulMessageButtonReturn,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Style.primaryMaroon,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
