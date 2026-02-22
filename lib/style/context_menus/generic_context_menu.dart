import 'dart:async';

import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:flutter/material.dart';

import 'core/base_context_menu.dart';
import 'core/context_menu_button.dart';
import 'core/context_menu_card.dart';

class GenericContextMenu extends BaseContextMenu {
  const GenericContextMenu({
    super.key,
    this.labels,
    this.actions,
    this.addDividers = false,
  });
  final List<String?>? labels;
  final List<VoidCallback>? actions;
  final bool addDividers;

  @override
  Widget build(BuildContext context) {
    if ((labels?.isEmpty ?? true) || (actions?.isEmpty ?? true)) {
      scheduleMicrotask(() {
        // Automatically close a context menu that would be empty anyways
        CloseContextMenuNotification().dispatch(context);
      });
      return Container();
    }
    if (addDividers) {
      for (var i = labels!.length - 2; i-- > 1; i++) {
        labels!.add(null);
      }
    }
    return ContextMenuCard(
      children: labels!.map((lbl) {
        if (lbl == null) return ContextDivider();
        VoidCallback action = actions![labels!.indexOf(lbl)];
        return ContextMenuBtn(
          lbl,
          onPressed: () => handlePressed(context, action),
        );
      }).toList(),
    );
  }
}
