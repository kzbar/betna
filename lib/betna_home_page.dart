import 'dart:async';

import 'package:betna/style/responsive/screen_type_layout.dart';
import 'package:betna/style/widget/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'generated/l10n.dart';

const Color kPrimary = Color(0xFF740247);
const Color kPrimaryDark = Color(0xFF4E0030);
const Color kPrimaryLight = Color(0xFFA74676);
const Color kBackground = Color(0xFFF8F3F5);
const Color kSoftChip = Color(0xFFEFCBDE);

class BetnaHomePage extends StatefulWidget {
  const BetnaHomePage({
    super.key,
  });

  @override
  State<BetnaHomePage> createState() => _BetnaHomePageState();
}

class _BetnaHomePageState extends State<BetnaHomePage> {
  bool _animate = false;
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    // Trigger simple entry animation
    _pageController = PageController();

    Future.microtask(() {
      if (mounted) {
        setState(() => _animate = true);
      }
    });

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (!_pageController.hasClients) return;

      final nextPage = (_currentPage + 1) % 3;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: kBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          final isWide = constraints.maxWidth > 720;
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    _buildTopBar(theme),
                    const SizedBox(height: 24),
                    _buildHeroSection(theme, isWide),
                    SizedBox(height: maxHeight * 0.05),
                    _buildInfoCards(theme),
                    SizedBox(height: maxHeight * 0.25),
                    _buildSocialRow(),
                    const SizedBox(height: 12),
                    _buildFooter(theme),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- Top Bar ----------------

  Widget _buildTopBar(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 48,
              padding: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    kPrimary,
                    kPrimaryLight,
                  ],
                ),
              ),
              child: Logo(
                withBackground: false,
                hi: 48,
                we: 48,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }

  // ---------------- Hero Section ----------------

  Widget _buildHeroSection(ThemeData theme, bool isWide) {
    final s = S.of(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: _animate ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        final offsetY = (1 - value) * 20;
        return Transform.translate(
          offset: Offset(0, offsetY),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: isWide ? 300 : 424,
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) {
                setState(() => _currentPage = i);
              },
              children: [
                // 1️⃣ سلايد بيع شقة
                _HeroSlideItem(
                  title: s.kBetnaHomePageSlide1Title,
                  subtitle: s.kBetnaHomePageSlide1Subtitle,
                  badge: s.kBetnaHomePageSlide1Badge,
                  //highlight: 'بيع شقق في إسطنبول',
                ),

                // 2️⃣ سلايد عروض جاهزة للبيع
                _HeroSlideItem(
                  //isWide,
                  title: s.kBetnaHomePageSlide2Title,
                  subtitle: s.kBetnaHomePageSlide2Subtitle,
                  badge: s.kBetnaHomePageSlide2Badge,
                  //highlight: 'شقق جاهزة للشراء',
                ),

                // 3️⃣ سلايد التقييم والاستشارة
                _HeroSlideItem(
                  //isWide,
                  title: s.kBetnaHomePageSlide3Title,
                  subtitle: s.kBetnaHomePageSlide3Subtitle,
                  badge: s.kBetnaHomePageSlide3Badge,
                  //highlight: 'استشارة عقارية',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (i) {
              final isActive = _currentPage == i;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: isActive ? 22 : 8,
                decoration: BoxDecoration(
                  color: isActive ? kPrimary : kPrimary.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ---------------- Social Row ----------------

  Widget _buildSocialRow() {
    final s = S.of(context);
    // You can replace '#' with real URLs using url_launcher.
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: _animate ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        final offsetY = (1 - value) * 20;
        return Transform.translate(
          offset: Offset(0, offsetY),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 8,
        children: [
          _SocialButton(
            icon: FontAwesomeIcons.whatsapp,
            label: s.kBetnaHomePageSocialWhatsapp,
            background: const Color(0xFF25D366),
            onTap: () {
              // TODO: launch WhatsApp link
            },
          ),
          _SocialButton(
            icon: Icons.camera_alt_rounded,
            label: s.kBetnaHomePageSocialInstagram,
            background: const Color(0xFFC13584),
            onTap: () {
              // TODO: launch Instagram link
            },
          ),
          _SocialButton(
            icon: Icons.facebook_rounded,
            label: s.kBetnaHomePageSocialFacebook,
            background: const Color(0xFF1877F2),
            onTap: () {
              // TODO: launch Facebook link
            },
          ),
          _SocialButton(
            icon: Icons.language_rounded,
            label: s.kBetnaHomePageSocialWebsite,
            background: kPrimary,
            onTap: () {
              // TODO: launch main website
            },
          ),
        ],
      ),
    );
  }

  // ---------------- Info Cards ----------------

  Widget _buildInfoCards(ThemeData theme) {
    final s = S.of(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: _animate ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        final offsetY = (1 - value) * 20;
        return Transform.translate(
          offset: Offset(0, offsetY),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {


          return Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _InfoTile(
                icon: Icons.sell_rounded,
                title: s.kBetnaHomePageInfoCard1Title,
                subtitle: s.kBetnaHomePageInfoCard1Subtitle,
              ),
              _InfoTile(
                icon: Icons.location_city_rounded,
                title: s.kBetnaHomePageInfoCard2Title,
                subtitle: s.kBetnaHomePageInfoCard2Subtitle,
              ),
              _InfoTile(
                icon: Icons.shield_rounded,
                title: s.kBetnaHomePageInfoCard3Title,
                subtitle: s.kBetnaHomePageInfoCard3Subtitle,
              ),
            ],
          );
        },
      ),
    );
  }

  // ---------------- Footer ----------------

  Widget _buildFooter(ThemeData theme) {
    final s = S.of(context);
    return Center(
      child: Text(
        s.kBetnaHomePageFooter(DateTime.now().year),
        style: theme.textTheme.bodySmall?.copyWith(
          color: kPrimaryDark.withOpacity(0.6),
        ),
      ),
    );
  }
}

class _HeroSlideItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badge;

  const _HeroSlideItem({required this.title, required this.subtitle, required this.badge});
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    String? lang = View.of(context).platformDispatcher.locale.languageCode;
    TextDirection direction = lang.contains('ar') ? TextDirection.ltr : TextDirection.rtl;

    final theme = Theme.of(context);
    return ScreenTypeLayout(
        desktop: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 6,
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    kPrimaryDark,
                    kPrimary,
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 24,
              ),
              child: Row(
                textDirection: direction,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      textDirection: direction,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: Colors.white.withAlpha(18)),
                          ),
                          child: Row(
                            textDirection: direction,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star_rounded, size: 18, color: Colors.white),
                              const SizedBox(width: 6),
                              Text(
                                textDirection: direction,
                                badge,
                                style: const TextStyle(fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          title,
                          textAlign: direction == TextDirection.ltr
                              ? TextAlign.right : TextAlign.left,
                          //textDirection: direction,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          subtitle,
                          //textDirection: direction,
                          textAlign: direction == TextDirection.ltr
                              ? TextAlign.right : TextAlign.left,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                overlayColor: Colors.white.withAlpha(10),
                                side: BorderSide(color: Colors.white.withAlpha(10)),
                              ),
                              onHover: (value) {},
                              onPressed: () {},
                              child: Text(
                                s.kBetnaHomePageBrowseOffers,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            FilledButton(
                              style: FilledButton.styleFrom(
                                foregroundColor: kPrimaryDark,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              ),
                              onPressed: () {},
                              child: Text(
                                s.kBetnaHomePageSubmitSaleRequest,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: _HeroSlideIllustration(),
                  ),
                ],
              ),
            )),
        mobile: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 6,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  kPrimaryDark,
                  kPrimary,
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white.withAlpha(18)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, size: 18, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        badge,
                        style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: direction == TextDirection.ltr
                      ? TextAlign.right : TextAlign.left,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  textAlign: direction == TextDirection.ltr
                      ? TextAlign.right : TextAlign.left,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  flex: 3,
                  child: _HeroSlideIllustration(),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white.withOpacity(0.5)),
                        ),
                        onPressed: () {},
                        child: Text(s.kBetnaHomePageBrowseOffers),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: kSoftChip,
                          foregroundColor: kPrimaryDark,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                        onPressed: () {},
                        child: Text(s.kBetnaHomePageSubmitSaleRequest),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class _HeroSlideIllustration extends StatelessWidget {
  const _HeroSlideIllustration();
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kPrimaryLight,
            kPrimary,
          ],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: 0.12,
              child: Icon(
                Icons.location_city_rounded,
                size: 150,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              s.kBetnaHomePageHeroIllustrationText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// -------- Social Button --------

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color background;
  final VoidCallback? onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.background,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: background.withAlpha(12),
          border: Border.all(color: background.withAlpha(50)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: background),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: background,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------- Info Tile --------

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return SizedBox(
      width: isWide ? 320 : double.infinity,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: kSoftChip.withAlpha(60),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: kPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,

                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,

                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
