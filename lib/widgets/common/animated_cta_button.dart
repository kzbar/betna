import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

class AnimatedCTAButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const AnimatedCTAButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  State<AnimatedCTAButton> createState() => _AnimatedCTAButtonState();
}

class _AnimatedCTAButtonState extends State<AnimatedCTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.diagonal3Values(
          _isHovered ? 1.05 : 1.0,
          _isHovered ? 1.05 : 1.0,
          1.0,
        ),
        child: FilledButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon ?? Icons.arrow_forward_rounded, size: 18),
          label: Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: _isHovered
                ? Style.luxuryGold
                : Style.primaryMaroon,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: Corners.medBorder),
            elevation: _isHovered ? 10 : 0,
            shadowColor: Style.primaryMaroon.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}
