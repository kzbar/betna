import 'package:betna/generated/l10n.dart';
import 'package:betna/providers/main_provider.dart';
import 'package:betna/providers/sale_request_provider.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationSection extends StatelessWidget {
  final bool isWide;
  final TextEditingController phoneCodeController;
  final TextEditingController emailCodeController;
  final String phoneNumber;
  final String email;

  const VerificationSection({
    super.key,
    required this.isWide,
    required this.phoneCodeController,
    required this.emailCodeController,
    required this.phoneNumber,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final saleProvider = Provider.of<SaleRequestProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).kSaleRequestTextVerificationTitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<VerificationMethod>(
                      title: Text(
                        S.of(context).kSaleRequestTextVerificationMethod1,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      activeColor: Style.primaryMaroon,
                      value: VerificationMethod.phone,
                      groupValue: saleProvider.verificationMethod,
                      onChanged: (v) => saleProvider.setVerificationMethod(v),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<VerificationMethod>(
                      title: Text(
                        S.of(context).kSaleRequestTextVerificationMethod2,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      activeColor: Style.primaryMaroon,
                      value: VerificationMethod.email,
                      groupValue: saleProvider.verificationMethod,
                      onChanged: (v) => saleProvider.setVerificationMethod(v),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (saleProvider.verificationMethod == VerificationMethod.phone)
          _buildPhoneField(context, saleProvider, theme),
        if (saleProvider.verificationMethod == VerificationMethod.email)
          _buildEmailField(context, saleProvider, theme),
      ],
    );
  }

  Widget _buildPhoneField(
    BuildContext context,
    SaleRequestProvider provider,
    ThemeData theme,
  ) {
    switch (provider.state) {
      case VerificationState.onSending:
      case VerificationState.onVerifying:
        return _fieldSized(
          context,
          isWide,
          Center(child: CircularProgressIndicator(color: Style.primaryMaroon)),
        );
      case VerificationState.onVerifyCompleted:
        return _buildSuccessIndicator(
          context,
          theme,
          S.of(context).kSaleRequestTextVerificationOkPhone,
        );
      case VerificationState.onSendCompleted:
        return _fieldSized(
          context,
          isWide,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: phoneCodeController,
                  keyboardType: TextInputType.number,
                  style: _textStyle(),
                  decoration: _inputDecoration(
                    theme,
                    S.of(context).kSaleRequestTextVerificationFieldPhone,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Style.primaryMaroon,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: Corners.smBorder),
                ),
                onPressed: () async {
                  final error = await provider.verifyPhoneCode(
                    phoneCodeController.text.trim(),
                  );
                  if (error != null) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(error)));
                  }
                },
                child: Text(
                  S.of(context).kSaleRequestTextVerificationFieldConfirmPhone,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      case VerificationState.none:
        return _fieldSized(
          context,
          isWide,
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Style.primaryMaroon,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: Corners.smBorder),
            ),
            onPressed: () => provider.sendPhoneCode(phoneNumber),
            child: Text(
              S.of(context).kSaleRequestTextVerificationSendCodePhone,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
    }
  }

  Widget _buildEmailField(
    BuildContext context,
    SaleRequestProvider provider,
    ThemeData theme,
  ) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    switch (provider.state) {
      case VerificationState.onSending:
      case VerificationState.onVerifying:
        return _fieldSized(
          context,
          isWide,
          Center(child: CircularProgressIndicator(color: Style.primaryMaroon)),
        );
      case VerificationState.onVerifyCompleted:
        return _buildSuccessIndicator(
          context,
          theme,
          S.of(context).kSaleRequestTextVerificationOkEmail,
        );
      case VerificationState.onSendCompleted:
        return _fieldSized(
          context,
          isWide,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: emailCodeController,
                  keyboardType: TextInputType.number,
                  style: _textStyle(),
                  decoration: _inputDecoration(
                    theme,
                    S.of(context).kSaleRequestTextVerificationFieldMail,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Style.primaryMaroon,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: Corners.smBorder),
                ),
                onPressed: () async {
                  final success = await provider.verifyEmailCode(
                    emailCodeController.text.trim(),
                  );
                  if (!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          S
                              .of(context)
                              .kSaleRequestTextVerificationPhoneMessage7,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  S.of(context).kSaleRequestTextVerificationFieldConfirmPhone,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      case VerificationState.none:
        return _fieldSized(
          context,
          isWide,
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Style.primaryMaroon,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: Corners.smBorder),
            ),
            onPressed: () async {
              final lang = mainProvider.currentLang!.name.toLowerCase();
              final error = await provider.sendEmailCode(email, lang);
              if (error != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(error)));
              }
            },
            child: Text(
              S.of(context).kSaleRequestTextVerificationSendCodeEmail,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
    }
  }

  Widget _buildSuccessIndicator(
    BuildContext context,
    ThemeData theme,
    String text,
  ) {
    return _fieldSized(
      context,
      isWide,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade600,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldSized(BuildContext context, bool isWide, Widget child) {
    final width = isWide
        ? (MediaQuery.of(context).size.width / 2) - 48
        : double.infinity;
    return SizedBox(width: width, child: child);
  }

  InputDecoration _inputDecoration(ThemeData theme, String label) {
    return InputDecoration(
      errorStyle: theme.textTheme.bodySmall?.copyWith(
        fontSize: 10,
        color: const Color(0xFFEF5350),
        fontWeight: FontWeight.w300,
      ),
      floatingLabelStyle: theme.textTheme.bodyMedium?.copyWith(
        fontSize: 14,
        color: Style.primaryMaroon,
        fontWeight: FontWeight.w600,
      ),
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        fontSize: 14,
        color: Colors.white.withValues(alpha: 0.5),
        fontWeight: FontWeight.w400,
      ),
      labelText: label,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Style.primaryMaroon),
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
  }
}
