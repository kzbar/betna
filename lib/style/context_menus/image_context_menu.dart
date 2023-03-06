import 'package:flutter/material.dart';

import 'core/base_context_menu.dart';
import 'core/context_menu_button.dart';
import 'core/context_menu_card.dart';

// TODO: Add this to all images, and finish it off by adding a FilePicker so images can be downloaded.
class ImageContextMenu extends BaseContextMenu {
  const ImageContextMenu({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ContextMenuCard(
      children: [
        ContextMenuBtn("Save Image as..."),
      ],
    );
  }
}
