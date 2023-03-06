import 'package:betna/style/input_utils.dart';
import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:flutter/material.dart';

import 'context_menus/app_context_menu.dart';

class StyledPageScaffold extends StatelessWidget {
  const StyledPageScaffold({Key? key, required this.body}) : super(key: key);
  @required final Widget body;

  @override
  Widget build(BuildContext context) {
    //TODO: Add a FocusTraversalGroup() when this bug is addressed:https://github.com/flutter/flutter/issues/74656
    return GestureDetector(
      onTap: InputUtils.unFocus,
      child: Scaffold(
        body: Stack(
          children: [
            ContextMenuRegion(child: Container(), contextMenu: AppContextMenu()),
            body,
          ],
        ),
      ),
    );
  }
}
