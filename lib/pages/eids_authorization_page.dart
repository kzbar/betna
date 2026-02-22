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

class EidsAuthorizationPage extends StatefulWidget {
  const EidsAuthorizationPage({super.key});

  @override
  State<EidsAuthorizationPage> createState() => _EidsAuthorizationPageState();
}

class _EidsAuthorizationPageState extends State<EidsAuthorizationPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

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
      backgroundColor: Style.luxuryCharcoal,
      endDrawer: const MobileDrawer(),
      body: Stack(
        children: [
          // Elegant gradient background
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

          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(height: isMobile ? 80 : 100), // spacing for Navbar
                _buildDynamicHeader(s, isMobile),
                _buildAuthorizationSteps(s, isMobile),
                const SizedBox(height: 60),
                _buildFooter(context, s),
              ],
            ),
          ),

          // Transparent fixed navbar overlay
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

  Widget _buildDynamicHeader(S s, bool isMobile) {
    return Container(
      width: double.infinity,
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Style.primaryMaroon,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  s.kEidsPageSubtitle.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Style.primaryMaroon,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Title
          Text(
            s.kEidsPageTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: isMobile ? 32 : 56,
              height: 1.1,
              color: Colors.white,

            ),
          ),
          const SizedBox(height: 24),
          // Warning Subtitle
          Text(
            s.kEidsPageWarning,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: isMobile ? 18 : 24,
              color: Style.primaryMaroon,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
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
        ],
      ),
    );
  }

  Widget _buildAuthorizationSteps(S s, bool isMobile) {
    final steps = [
      s.kEidsStep1,
      s.kEidsStep2,
      s.kEidsStep3,
      s.kEidsStep4,
      s.kEidsStep5,
      s.kEidsStep6,
      s.kEidsStep7,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
      child: Column(
        children: [
          Text(
            s.kEidsPageQuestion,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              borderRadius: Corners.medBorder,
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            padding: EdgeInsets.all(isMobile ? 24 : 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < steps.length; i++) ...[
                  _buildStepItem(i + 1, steps[i], s, i == 3, isMobile),
                  if (i < steps.length - 1)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Container(
                        width: 2,
                        height: 30,
                        color: Style.luxuryGold.withValues(alpha: 0.3),
                      ),
                    ),
                ],
                const SizedBox(height: 48),
                Center(
                  child: Column(
                    children: [
                      Text(
                        s.kEidsFooterNote,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 32),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () =>
                              _launchURL("https://www.turkiye.gov.tr/"),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Style.primaryMaroon,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Style.primaryMaroon.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Text(
                              s.kEidsGoToEDevlet,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(
    int stepNumber,
    String text,
    S s,
    bool isStep4,
    bool isMobile,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Style.luxuryGold.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Style.luxuryGold, width: 2),
          ),
          child: Center(
            child: Text(
              stepNumber.toString(),
              style: TextStyle(
                color: Style.luxuryGold,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isStep4) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                        children: [
                          TextSpan(text: s.kEidsStep4Note),
                          TextSpan(
                            text: " 3412275",
                            style: TextStyle(
                              color: Style.primaryMaroon,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- STANDARD NAVBAR & FOOTER ---

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
                        onTap: () => Navigator.pushNamed(context, '/'),
                        child: Logo(
                          hi: isMobile ? 32 : 40,
                          we: isMobile ? 90 : 110,
                          withBackground: false,
                        ),
                      ),
                    ),
                    const Spacer(),
                    _buildLanguageSwitcher(mainProvider, isMobile),
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
