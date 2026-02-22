import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

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
               borderRadius: BorderRadius.circular(16),
             ),
           );
         },
       );
}
