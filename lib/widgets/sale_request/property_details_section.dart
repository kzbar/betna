import 'package:betna/generated/l10n.dart';
import 'package:betna/providers/sale_request_provider.dart';
import 'package:betna/style/style.dart';
import 'package:betna/widgets/common/form_fields.dart';
import 'package:flutter/material.dart';

class PropertyDetailsSection extends StatelessWidget {
  final bool isWide;
  final TextEditingController totalAreaController;
  final TextEditingController priceController;
  final TextEditingController complexNameController;
  final String? rooms;
  final String? floor;
  final String? age;
  final bool inResidenceComplex;
  final OccupancyStatus occupancy;
  final Function(String?) onRoomsChanged;
  final Function(String?) onFloorChanged;
  final Function(String?) onAgeChanged;
  final Function(bool) onComplexChanged;
  final Function(OccupancyStatus) onOccupancyChanged;

  const PropertyDetailsSection({
    super.key,
    required this.isWide,
    required this.totalAreaController,
    required this.priceController,
    required this.complexNameController,
    required this.rooms,
    required this.floor,
    required this.age,
    required this.inResidenceComplex,
    required this.occupancy,
    required this.onRoomsChanged,
    required this.onFloorChanged,
    required this.onAgeChanged,
    required this.onComplexChanged,
    required this.onOccupancyChanged,
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
          DropdownButtonFormField<String>(
            initialValue: rooms,
            dropdownColor: Style.luxurySurface,
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField4,
            ),
            items: SaleRequestProvider.roomTypes
                .map(
                  (r) => DropdownMenuItem(
                    value: r,
                    child: Text(r, style: _dropdownStyle()),
                  ),
                )
                .toList(),
            onChanged: onRoomsChanged,
            validator: (v) => v == null
                ? S.of(context).kSaleRequestTextFieldErrorMessage4
                : null,
          ),
        ),
        _fieldSized(
          context,
          isWide,
          TextFormField(
            controller: totalAreaController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: _textStyle(),
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField5,
            ),
            validator: (v) {
              final parsed = double.tryParse((v ?? '').replaceAll(',', '.'));
              if (parsed == null || parsed <= 0) {
                return S.of(context).kSaleRequestTextFieldErrorMessage5;
              }
              return null;
            },
          ),
        ),
        _fieldSized(
          context,
          isWide,
          DropdownButtonFormField<String>(
            initialValue: floor,
            dropdownColor: Style.luxurySurface,
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField6,
            ),
            items: SaleRequestProvider.floorsList
                .map(
                  (r) => DropdownMenuItem(
                    value: r,
                    child: Text(r, style: _dropdownStyle()),
                  ),
                )
                .toList(),
            onChanged: onFloorChanged,
            validator: (v) => v == null
                ? S.of(context).kSaleRequestTextFieldErrorMessage6
                : null,
          ),
        ),
        _fieldSized(
          context,
          isWide,
          DropdownButtonFormField<String>(
            initialValue: age,
            dropdownColor: Style.luxurySurface,
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField7,
            ),
            items: SaleRequestProvider.agesList
                .map(
                  (r) => DropdownMenuItem(
                    value: r,
                    child: Text(r, style: _dropdownStyle()),
                  ),
                )
                .toList(),
            onChanged: onAgeChanged,
            validator: (v) => v == null
                ? S.of(context).kSaleRequestTextFieldErrorMessage7
                : null,
          ),
        ),
        _fieldSized(
          context,
          isWide,
          SwitchListTileFormField(
            title: Text(
              S.of(context).kSaleRequestTextField8,
              style: _textStyle(),
            ),
            initialValue: inResidenceComplex,
            onChanged: onComplexChanged,
          ),
        ),
        if (inResidenceComplex)
          _fieldSized(
            context,
            isWide,
            TextFormField(
              controller: complexNameController,
              style: _textStyle(),
              decoration: _inputDecoration(
                theme,
                S.of(context).kSaleRequestTextField9,
              ),
              validator: (v) {
                if (inResidenceComplex && (v == null || v.trim().isEmpty)) {
                  return S.of(context).kSaleRequestTextFieldErrorMessage9;
                }
                return null;
              },
            ),
          ),
        _fieldSized(
          context,
          isWide,
          DropdownButtonFormField<OccupancyStatus>(
            initialValue: occupancy,
            dropdownColor: Style.luxurySurface,
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField10,
            ),
            items: OccupancyStatus.values.map((st) {
              return DropdownMenuItem(
                value: st,
                child: Text(st.label(context), style: _dropdownStyle()),
              );
            }).toList(),
            onChanged: (v) => onOccupancyChanged(v ?? OccupancyStatus.vacant),
          ),
        ),
        _fieldSized(
          context,
          isWide,
          TextFormField(
            controller: priceController,
            style: _textStyle(),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: _inputDecoration(
              theme,
              S.of(context).kSaleRequestTextField11,
            ),
            validator: (v) {
              final parsed = double.tryParse((v ?? '').replaceAll(',', '.'));
              if (parsed == null || parsed <= 0) {
                return S.of(context).kSaleRequestTextFieldErrorMessage11;
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

  TextStyle _dropdownStyle() {
    return TextStyle(
      fontSize: 12,
      color: Colors.white.withValues(alpha: 0.8),
      fontWeight: FontWeight.w500,
    );
  }
}
