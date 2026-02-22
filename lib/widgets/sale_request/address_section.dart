import 'package:betna/generated/l10n.dart';
import 'package:betna/providers/sale_request_provider.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressSection extends StatelessWidget {
  final bool isWide;
  final TextEditingController streetController;

  const AddressSection({
    super.key,
    required this.isWide,
    required this.streetController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final saleProvider = Provider.of<SaleRequestProvider>(context);

    final districts = saleProvider.neighborhoodsByDistrict.keys.toList()
      ..sort();
    final neighborhoods =
        saleProvider.selectedDistrict == null
              ? <String>[]
              : (saleProvider.neighborhoodsByDistrict[saleProvider
                        .selectedDistrict] ??
                    <String>[])
          ..sort();

    return Wrap(
      runSpacing: 16,
      spacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _fieldSized(
          context,
          isWide,
          DropdownButtonFormField<String>(
            initialValue: saleProvider.selectedDistrict,
            dropdownColor: Style.luxurySurface,
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField1,
            ),
            items: districts
                .map(
                  (d) => DropdownMenuItem(
                    value: d,
                    child: Text(d, style: _dropdownStyle()),
                  ),
                )
                .toList(),
            onChanged: (value) => saleProvider.setSelectedDistrict(value),
            validator: (v) => v == null
                ? S.of(context).kSaleRequestTextFieldErrorMessage1
                : null,
          ),
        ),
        _fieldSized(
          context,
          isWide,
          DropdownButtonFormField<String>(
            initialValue: saleProvider.selectedNeighborhood,
            dropdownColor: Style.luxurySurface,
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField2,
            ),
            items: neighborhoods
                .map(
                  (d) => DropdownMenuItem(
                    value: d,
                    child: Text(d, style: _dropdownStyle()),
                  ),
                )
                .toList(),
            onChanged: neighborhoods.isEmpty
                ? null
                : (value) => saleProvider.setSelectedNeighborhood(value),
            validator: (v) => v == null
                ? S.of(context).kSaleRequestTextFieldErrorMessage2
                : null,
          ),
        ),
        _fieldSized(
          context,
          isWide,
          TextFormField(
            controller: streetController,
            style: _textStyle(),
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField3,
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? S.of(context).kSaleRequestTextFieldErrorMessage3
                : null,
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

  TextStyle _dropdownStyle() {
    return TextStyle(
      fontSize: 12,
      color: Colors.white.withValues(alpha: 0.8),
      fontWeight: FontWeight.w500,
    );
  }
}
