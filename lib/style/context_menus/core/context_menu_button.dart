import 'package:flutter/material.dart';

// A single ContextMenu button
class ContextMenuBtn extends StatefulWidget {
  const ContextMenuBtn(
    this.label, {
    super.key,
    this.onPressed,
    this.icon,
    this.shortcutLabel,
    this.hoverBgColor,
    this.iconColor,
  });
  final String label;
  final String? shortcutLabel;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? iconColor;
  final Color? hoverBgColor;

  @override
  State<ContextMenuBtn> createState() => _ContextMenuBtnState();
}

class _ContextMenuBtnState extends State<ContextMenuBtn> {
  bool _isMouseOver = false;
  set isMouseOver(bool isMouseOver) =>
      setState(() => _isMouseOver = isMouseOver);
  @override
  Widget build(BuildContext context) {
    //AppTheme theme = context.watch();
    bool isDisabled = widget.onPressed == null;
    bool showMouseOver = _isMouseOver && !isDisabled;
    //Color fgColor = Colors.red;
    return GestureDetector(
      onTapDown: (_) => isMouseOver = true,
      onTapUp: (_) {
        isMouseOver = false;
        widget.onPressed?.call();
      },
      child: MouseRegion(
        onEnter: (_) => isMouseOver = true,
        onExit: (_) => isMouseOver = false,
        cursor: !isDisabled ? SystemMouseCursors.click : MouseCursor.defer,
        child: Opacity(
          opacity: isDisabled ? .7 : 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: 100,
            color: showMouseOver
                ? (widget.hoverBgColor ?? Colors.black)
                : Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Optional Icon
                if (widget.icon != null) ...[
                  //AppIcon(widget.icon, size: 16, color: widget.iconColor ?? fgColor),
                  // HSpace.med,
                ],

                /// Main Label
                Text(widget.label, style: const TextStyle(fontSize: 12)),
                const Spacer(),

                /// Shortcut Label
                if (widget.shortcutLabel != null) ...[
                  Opacity(
                    opacity: showMouseOver ? 1 : .7,
                    child: Text(
                      widget.shortcutLabel!,
                      //style: TextStyles.caption.copyWith(color: fgColor)
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
