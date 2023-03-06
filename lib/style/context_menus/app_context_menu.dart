
import 'package:flutter/material.dart';


import 'core/base_context_menu.dart';
import 'core/context_menu_button.dart';
import 'core/context_menu_card.dart';

class AppContextMenu extends BaseContextMenu {
  //void _handleSignoutPressed() => {};
  @override
  Widget build(BuildContext context) {
    //bool isLoggedIn = context.select((AppModel am) => am.isAuthenticated);
    return ContextMenuCard(
      children: [
        if (true) ...[
          ContextMenuBtn("GO TO EDIT", onPressed: () => handlePressed(context, (){
          })),
        ],
      ],
    );
  }
}
