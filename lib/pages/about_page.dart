import 'package:betna/generated/l10n.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/logo_widget.dart';
import 'package:betna/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:betna/setup/enumerators.dart';
import 'dart:ui';
import 'package:betna/widgets/home/mobile_drawer.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  // Section Keys for smooth scrolling
  final GlobalKey _aboutKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isMobile = MediaQuery.of(context).size.width <= 700;

    return Scaffold(
      endDrawer: const MobileDrawer(),
      body: Stack(
        children: [
          // Background Gradient matching Betna design
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Style.luxuryCharcoal,
                  Style.luxuryCharcoal.withValues(alpha: 0.95),
                  Style.luxuryCharcoal,
                ],
              ),
            ),
          ),

          // Main Content List
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(height: isMobile ? 80 : 100), // Navbar spacing
                // 1. Hero / About Us Section
                Container(
                  key: _aboutKey,
                  child: _buildAboutSection(context, s, isMobile),
                ),

                // Footer
                _buildFooter(context, s),
              ],
            ),
          ),

          // Navbar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildNavbar(context, s, isMobile),
          ),
        ],
      ),
    );
  }

  // Navbar similar to Homepage
  Widget _buildNavbar(BuildContext context, S s, bool isMobile) {
    final isScrolled = _scrollOffset > 50;
    final mainProvider = Provider.of<MainProvider>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: isScrolled
          ? Style.luxuryCharcoal.withValues(alpha: 0.9)
          : Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 12 : 20,
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: isScrolled ? 10 : 0,
            sigmaY: isScrolled ? 10 : 0,
          ),
          child: Builder(
            builder: (context) {
              return SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Logo(
                          hi: isMobile ? 32 : 40,
                          we: isMobile ? 90 : 110,
                          withBackground: false,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Nav links (desktop)
                    if (MediaQuery.of(context).size.width > 900) ...[
                      _navLink(
                        S.of(context).kAboutPageTitle,
                        () => _scrollToSection(_aboutKey),
                      ),
                      const SizedBox(width: 40),
                    ],
                    // Language Switcher Pill
                    _buildLanguageSwitcher(mainProvider, isMobile),
                    // Hamburger Menu (mobile and tablet)
                    if (MediaQuery.of(context).size.width <= 900) ...[
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _navLink(String label, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSwitcher(MainProvider mainProvider, bool isMobile) {
    String currentLang = mainProvider.currentLang == Lang.AR
        ? 'AR'
        : mainProvider.currentLang == Lang.TR
        ? 'TR'
        : 'EN';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _langToggle(
            'EN',
            currentLang == 'EN',
            () => mainProvider.changeCurrentLang(Lang.EN),
            isMobile,
          ),
          _langToggle(
            'AR',
            currentLang == 'AR',
            () => mainProvider.changeCurrentLang(Lang.AR),
            isMobile,
          ),
          _langToggle(
            'TR',
            currentLang == 'TR',
            () => mainProvider.changeCurrentLang(Lang.TR),
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _langToggle(
    String label,
    bool isActive,
    VoidCallback onTap,
    bool isMobile,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16,
            vertical: isMobile ? 6 : 8,
          ),
          decoration: BoxDecoration(
            color: isActive ? Style.primaryMaroon : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isActive
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.5),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  // 1. About Us Section
  Widget _buildAboutSection(BuildContext context, S s, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Style.primaryMaroon.withValues(alpha: 0.1),
              borderRadius: Corners.medBorder,
              border: Border.all(
                color: Style.primaryMaroon.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              s.kAboutPageTitle.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Style.primaryMaroon,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            s.kAboutUsSectionTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: isMobile ? 32 : 56,
              height: 1.1,
            ),
          ),

          const SizedBox(height: 16),
          // Accent Line
          Container(
            width: 80,
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Style.luxuryGold,
                  Style.luxuryGold.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 32),
          // Description
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              s.kAboutUsSectionText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: isMobile ? 16 : 20,
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, S s) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _footerSocialLink(
                s.kBetnaHomePageInstagram,
                Icons.camera_alt,
                'https://instagram.com/betna',
              ),
              const SizedBox(width: 32),
              _footerSocialLink(
                s.kBetnaHomePageFacebook,
                Icons.facebook,
                'https://facebook.com/betna',
              ),
              const SizedBox(width: 32),
              _footerSocialLink(
                s.kBetnaHomePageWhatsapp,
                Icons.message,
                'https://wa.me/90xxxxxxxxxx',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            s.kBetnaHomePageFooter(DateTime.now().year),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerSocialLink(String label, IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
