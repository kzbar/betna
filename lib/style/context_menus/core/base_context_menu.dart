import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:flutter/material.dart';

// Base class for all ContextMenus.
// Provides a handlePressed method that takes care of closing the menu after some action has been run.
abstract class BaseContextMenu extends StatelessWidget {
  const BaseContextMenu({super.key});
  // Convenience method so each menu item does not need to manually Close the context menu.
  void handlePressed(BuildContext context, VoidCallback action) {
    action.call();
    CloseContextMenuNotification().dispatch(context);
  }
}

// Shared divider Widget
class ContextDivider extends StatelessWidget {
  const ContextDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Divider(color: Colors.grey, height: .5),
    );
  }
}
