import 'package:betna/generated/l10n.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

class PropertyTicker extends StatefulWidget {
  final List<String> items;

  const PropertyTicker({super.key, required this.items});

  @override
  State<PropertyTicker> createState() => _PropertyTickerState();
}

class _PropertyTickerState extends State<PropertyTicker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final GlobalKey _rowKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Three copies so there's always content after the visible window.
    final displayItems = [...widget.items, ...widget.items, ...widget.items];

    return Container(
      height: 64,
      color: Style.luxuryCharcoal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left "PROPERTIES" label
          Container(
            color: Style.primaryMaroon,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(
              S.of(context).kBetnaHomePageProperties,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 11,
              ),
            ),
          ),
          // Scrolling ticker â€” ClipRect hides the overflow.
          Expanded(
            child: ClipRect(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  // Read real unconstrained width from the OverflowBox child.
                  // Layout is already done by the time builder fires.
                  double singleSetWidth = 0;
                  final box =
                      _rowKey.currentContext?.findRenderObject() as RenderBox?;
                  if (box != null && box.hasSize) {
                    singleSetWidth = box.size.width / 3;
                  }

                  final offset = singleSetWidth > 0
                      ? _controller.value * singleSetWidth
                      : 0.0;

                  return Transform.translate(
                    offset: Offset(-offset, 0),
                    child: child,
                  );
                },
                child: OverflowBox(
                  minWidth: 0,
                  maxWidth: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    key: _rowKey,
                    mainAxisSize: MainAxisSize.min,
                    children: displayItems.map(_buildTickerItem).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTickerItem(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 24),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: Style.primaryMaroon,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 24),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
