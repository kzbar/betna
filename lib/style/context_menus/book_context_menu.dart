import 'package:flutter/material.dart';

import 'core/base_context_menu.dart';
import 'core/context_menu_button.dart';
import 'core/context_menu_card.dart';

class BookContextMenu extends BaseContextMenu {
  BookContextMenu();

  void _handleViewPressed(BuildContext context) => {};
  void _handleSharePressed() => {};
  void _handleDeletePressed() {
    //DeleteBookCommand().run(book);
  }

  @override
  Widget build(BuildContext context) {
    //AppTheme theme = context.watch();
    return ContextMenuCard(
      children: [
        ContextMenuBtn("View",
            icon: Icons.view_agenda, onPressed: () => handlePressed(context, () => _handleViewPressed(context))),
        ContextDivider(),
        ContextMenuBtn("Share",
            icon: Icons.share, onPressed: () => handlePressed(context, () => _handleSharePressed())),
        ContextDivider(),
        ContextMenuBtn("Delete",
            icon: Icons.delete,
            onPressed: () => handlePressed(context, () => _handleDeletePressed())),
      ],
    );
  }
}
