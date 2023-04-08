import 'package:flutter/material.dart';

class HoverIcon extends StatefulWidget {
  final IconData? data;
  final Color? backgroundColorHover;
  final Color? backgroundColor;
  final double size;
  final EdgeInsets margin;

  const HoverIcon(
      {Key? key,
      this.data,
      this.backgroundColorHover,
      this.backgroundColor, this.size = 24, this.margin = const EdgeInsets.all(6),
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HoverIcon();
}

class _HoverIcon extends State<HoverIcon> {
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
        padding: EdgeInsets.all(0.0),
        margin: widget.margin,
        duration: Duration(milliseconds: 400),
        child: Icon(
          widget.data,
          size: widget.size,
          color: isHover ? widget.backgroundColorHover : widget.backgroundColor,
        ),
      ),
    );
  }
}
