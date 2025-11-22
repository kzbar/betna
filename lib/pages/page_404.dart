import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  const Page404({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF740247);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF120017),
              Color(0xFF2B0823),
              primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 800;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildIllustration(primaryColor,context),
                          const SizedBox(width: 48),
                          _buildTextSection(context, isWide),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration(Color primaryColor,BuildContext context, {bool isWide = true}) {
    final double size = isWide ? 260 : 200;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            primaryColor.withValues(alpha: 0.3),
            primaryColor.withValues(alpha: 0.05),
          ],
          stops: const [0.2, 1.0],
        ),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.6),
            blurRadius: 35,
            spreadRadius: 2,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 404 circle
          Text(
            '404',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white.withValues(alpha: 0.95),fontSize: isWide ? 72 : 56,letterSpacing: 6, fontWeight: FontWeight.w800,)
          ),
          // small floating house icon
          Positioned(
            top: size * 0.22,
            right: size * 0.18,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
              child: Icon(
                Icons.home_work_rounded,
                color: Colors.white.withValues(alpha: 0.95),
                size: isWide ? 30 : 24,
              ),
            ),
          ),
          Positioned(
            bottom: size * 0.18,
            left: size * 0.20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children:  [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Property does not exist',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSection(BuildContext context, bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Page not found',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Padding(padding: EdgeInsetsGeometry.all(24),child: Text(
          'It appears you ve reached an address that doesnt exist on Betna. The page may have moved or the link may be broken.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
            height: 1.6,
          ),
        ),),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            _buildPrimaryButton(context),
            _buildOutlineButton(context),
          ],
        ),
        const SizedBox(height: 24),
        _fieldSized(
            isWide,
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.info_outline, color: Colors.white60, size: 18),
                const SizedBox(width: 6),
                Text(
                  "If you got here via a link from outside the site, try returning to the homepage",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white60,
                    height: 1.6,
                    fontSize: 8,
                  ),

                )
              ],
            ),
            context: context)
      ],
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    const primaryColor = Color(0xFF740247);

    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 2,
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/');
      },
      icon: const Icon(Icons.home_rounded, size: 20),
      label:  Text(
        'Return to homepage',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
      ),
    );
  }

  Widget _buildOutlineButton(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.6),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: () {
        // Example: reload current route or open contact page
        // You can customize this
      },
      icon: const Icon(Icons.support_agent_outlined, size: 18),
      label:  Text(
        'Contact the Betna team',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _fieldSized(bool isWide, Widget child, {BuildContext? context}) {
    final width = isWide
        ? (MediaQuery.of(context!).size.width / 2) - 48
        : double.infinity;
    return SizedBox(width: width, child: child);
  }
}
