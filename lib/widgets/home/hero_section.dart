import 'package:betna/generated/l10n.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

class HeroSection extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? badge;
  final String backgroundImage;
  final double scrollOffset;

  const HeroSection({
    super.key,
    required this.title,
    required this.subtitle,
    this.badge,
    required this.backgroundImage,
    this.scrollOffset = 0,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _zoomController;

  @override
  void initState() {
    super.initState();
    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    if (isWide) {
      return _buildWideLayout(context, size);
    } else {
      return _buildMobileLayout(context, size);
    }
  }

  Widget _buildWideLayout(BuildContext context, Size size) {
    final vPad = (size.height * 0.1).clamp(40.0, 85.0);
    return SizedBox(
      height: size.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // LEFT â€” Typography Column
          Expanded(
            flex: 5,
            child: Container(
              color: Style.luxuryCharcoal,
              padding: EdgeInsets.fromLTRB(80, vPad * 1.5, 64, vPad),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(flex: 2),
                       
                        _buildMainTitle(context),
                        const SizedBox(height: 24),
                        _buildSubtitle(context),
                        const Spacer(flex: 3),
                       
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 6, child: _buildCinematicImage(size.height)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, Size size) {
    return SizedBox(
      height: size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildCinematicImage(size.height),
          // Darker gradients for mobile readability
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.4, 0.7, 1.0],
                  colors: [
                    Style.luxuryCharcoal.withValues(alpha: 0.6),
                    Colors.transparent,
                    Style.luxuryCharcoal.withValues(alpha: 0.8),
                    Style.luxuryCharcoal,
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Style.luxuryCharcoal.withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.badge != null) ...[
                    _buildBadge(context),
                    const SizedBox(height: 24),
                  ],
                  _buildMainTitle(context),
                  const SizedBox(height: 20),
                  _buildSubtitle(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCinematicImage(double containerHeight) {
    return AnimatedBuilder(
      animation: _zoomController,
      builder: (context, child) {
        final zoomScale = 1.0 + (_zoomController.value * 0.1);
        return ClipRect(
          child: Transform.scale(
            scale: zoomScale,
            child: Transform.translate(
              offset: Offset(0, -widget.scrollOffset * 0.5),
              child: Image.network(
                widget.backgroundImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withValues(alpha: 0.1),
                colorBlendMode: BlendMode.darken,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Style.luxurySurface),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadge(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.badge!.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Style.primaryMaroon,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Container(width: 40, height: 2, color: Style.primaryMaroon),
      ],
    );
  }

  Widget _buildMainTitle(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;
    final fontSize = (w * 0.038).clamp(32.0, isWide ? 64.0 : 40.0);

    // split title at \n if exists
    final parts = widget.title.split('\n');

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          height: 1.05,
          fontSize: fontSize,
        ),
        children: [
          TextSpan(text: parts[0]),
          if (parts.length > 1) ...[
            const TextSpan(text: '\n'),
            TextSpan(
              text: parts[1],
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Style.luxuryGold,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      widget.subtitle,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Colors.white.withValues(alpha: 0.5),
        fontSize: 15,
        height: 1.8,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _buildScrollHint(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PulsingBar(),
        const SizedBox(height: 16),
        Text(
          S.of(context).kBetnaHomePageScrollDown,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.3),
            fontSize: 9,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _PulsingBar extends StatefulWidget {
  @override
  State<_PulsingBar> createState() => _PulsingBarState();
}

class _PulsingBarState extends State<_PulsingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 2,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, _animation.value, _animation.value + 0.1, 1],
              colors: [
                Style.primaryMaroon.withValues(alpha: 0.1),
                Style.primaryMaroon,
                Style.primaryMaroon.withValues(alpha: 0.5),
                Style.primaryMaroon.withValues(alpha: 0.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
