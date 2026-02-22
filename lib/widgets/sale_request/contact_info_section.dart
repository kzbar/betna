import 'package:betna/generated/l10n.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

class ContactInfoSection extends StatelessWidget {
  final bool isWide;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  const ContactInfoSection({
    super.key,
    required this.isWide,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      runSpacing: 16,
      spacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _fieldSized(
          context,
          isWide,
          TextFormField(
            controller: nameController,
            style: _textStyle(),
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField12,
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? S.of(context).kSaleRequestTextFieldErrorMessage12
                : null,
          ),
        ),
        _fieldSized(
          context,
          isWide,
          TextFormField(
            controller: phoneController,
            style: _textStyle(),
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField13,
            ),
            validator: (v) {
              final raw = v?.trim() ?? '';
              if (raw.isEmpty) {
                return S.of(context).kSaleRequestTextFieldErrorMessage13;
              }
              return null;
            },
          ),
        ),
        _fieldSized(
          context,
          isWide,
          TextFormField(
            controller: emailController,
            style: _textStyle(),
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField14,
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return S.of(context).kSaleRequestTextFieldErrorMessage14;
              }
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(v.trim())) {
                return S.of(context).kSaleRequestTextFieldErrorMessage14;
              }
              return null;
            },
          ),
        ),
      ],
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
