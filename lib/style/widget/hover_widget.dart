import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? backgroundColorHover;
  final Color? backgroundColor;
  final TextDirection? direction;
  final Widget widget;
  final double borderRadius;

  const HoverWidget(
      {Key? key,
      this.height,
      this.width,
      this.backgroundColorHover,
      this.backgroundColor, this.direction, required this.widget, this.borderRadius = 0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HoverWidget();
}

class _HoverWidget extends State<HoverWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHover = true;
      }),
      onExit: (_) => setState(() {
        isHover = false;
      }),

      child: AnimatedContainer(
        alignment: Alignment.center,
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.all(3),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: isHover ? widget.backgroundColorHover : widget.backgroundColor,
        ),
        duration: Duration(milliseconds: 400),
        child: widget.widget,
      ),
    );
  }
}
