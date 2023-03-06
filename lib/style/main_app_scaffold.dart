import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:betna/style/popover/popover_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


/// Wraps the entire app, providing it with various helper classes and wrapper widgets.
class MainAppScaffold extends StatefulWidget {
  const MainAppScaffold({Key? key, required this.child,}) : super(key: key);
  @required final Widget child;

  @override
  _MainAppScaffoldState createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  @override
  Widget build(BuildContext context) {
    return ContextMenuOverlay(
      child: PopOverController(
        // Draw a border around the entire window, because we're classy :)
        child: widget.child,
      ),
    );
  }
}
