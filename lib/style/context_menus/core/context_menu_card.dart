import 'package:flutter/material.dart';

// Styled Background for each ContextMenu
class ContextMenuCard extends StatelessWidget {
  const ContextMenuCard({super.key, this.children});
  final List<Widget>? children;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey,
        // borderRadius: Corners.smBorder,
        // boxShadow: Shadows.universal,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children!,
      ),
    );
  }
}
