import 'package:betna/generated/l10n.dart';
import 'package:betna/pages/sale_request_page.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/logo_widget.dart';
import 'package:betna/widgets/home/hero_section.dart';
import 'package:betna/widgets/home/property_ticker.dart';
import 'package:betna/widgets/home/mobile_drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:betna/providers/property_provider.dart';
import 'package:betna/models/property_model.dart';
import 'dart:ui';
import 'package:betna/providers/main_provider.dart';
import 'package:betna/setup/enumerators.dart';
import 'package:url_launcher/url_launcher.dart';

class BetnaHomePage extends StatefulWidget {
  const BetnaHomePage({super.key});

  @override
  State<BetnaHomePage> createState() => _BetnaHomePageState();
}

class _BetnaHomePageState extends State<BetnaHomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  static const _tickerItems = [
    'BOSPHORUS VIEW RESIDENCE \u2014 ISTANBUL \u00b7 \$1,200,000',
    'GARDEN CITY VILLAS \u2014 BEYLIKD\u00dcZ\u00dc \u00b7 \$850,000',
    'SKYLINE TOWER \u2014 BA\u015eAK\u015eEHIR \u00b7 \$600,000',
    'MARINA PENTHOUSE \u2014 BE\u015eIKTA\u015e \u00b7 \$3,500,000',
    'TOPKAPI GARDENS \u2014 ZEYTINBURNU \u00b7 \$490,000',
    'HARBOUR ELITE \u2014 ATA\u015eEHIR \u00b7 \$1,750,000',
  ];

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

  Future<void> _launchURL(String url) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }

  void _goToSaleRequest() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SaleRequestPage()));
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final propertyProvider = Provider.of<PropertyProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      endDrawer: const MobileDrawer(),
      // Sticky WhatsApp button \u2014 mobile only
      floatingActionButton: MediaQuery.of(context).size.width <= 700
          ? FloatingActionButton.extended(
              onPressed: () =>
                  _launchURL('https://wa.me/message/WTBMCUW6NPAQA1'),
              backgroundColor: const Color(0xFF25D366),
              icon: const Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 18,
              ),
              label: Text(
                s.kServicesContactUs,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          : null,
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. HERO + TICKER â€” ticker pinned to bottom of hero
                HeroSection(
                  title: s.kBetnaHomePageHeroTextBlockTitle,
                  subtitle: s.kBetnaHomePageHeroTextBlockSubtitle,
                  badge: s.kBetnaHomePageHeroTextBlockBadge,
                  backgroundImage:
                      'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&q=80&w=1500',
                  scrollOffset: _scrollOffset,
                ),
                if (propertyProvider.properties.isNotEmpty) ...[
                  PropertyTicker(
                    items: propertyProvider.tickerItems.isEmpty
                        ? _tickerItems
                        : propertyProvider.tickerItems,
                  ),
                ],

                // 2. PROPERTY SHOWCASE (with inline filters)
                _buildPropertyShowcase(context, s),

                // 3. WHY BETNA
                _buildWhyBetnaSection(context, s),

                // 4. SERVICES
                _buildServicesSection(context, s),

                // 5. EIDS AUTHORIZATION
                _buildEidsBanner(context, s),

                // 6. CTA BAND
                _buildCtaBand(context, s),

                // 7. FOOTER
                _buildFooter(context, s),
              ],
            ),
          ),

          // Transparent floating navbar
          Positioned(top: 0, left: 0, right: 0, child: _buildNavbar(context)),
        ],
      ),
    );
  }

  Widget _buildNavbar(BuildContext context) {
    final isScrolled = _scrollOffset > 80;
    final isMobile = MediaQuery.of(context).size.width <= 700;
    final mainProvider = Provider.of<MainProvider>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: isScrolled
          ? Style.luxuryCharcoal.withValues(alpha: 0.8)
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
                    GestureDetector(
                      onLongPress: () => Navigator.pushNamed(context, '/admin'),
                      child: Logo(
                        hi: isMobile ? 32 : 40,
                        we: isMobile ? 90 : 110,
                        withBackground: false,
                      ),
                    ),
                    const Spacer(),
                    // Nav links (desktop)
                    if (MediaQuery.of(context).size.width > 900) ...[
                      _navLink(
                        S.of(context).kProjectsSectionTitle,
                        () => Navigator.pushNamed(context, '/projects'),
                      ),
                      const SizedBox(width: 40),
                      _navLink(
                        S.of(context).kResaleSectionTitle,
                        () => Navigator.pushNamed(context, '/resale'),
                      ),
                      const SizedBox(width: 40),
                      _navLink(
                        S.of(context).kBetnaHomePageAbout,
                        () => Navigator.pushNamed(context, '/about'),
                      ),
                      const SizedBox(width: 40),
                    ],
                    // Language Switcher Pill
                    _buildLanguageSwitcher(mainProvider, isMobile),
                    if (!isMobile) const SizedBox(width: 24),
                    // WhatsApp CTA
                    if (!isMobile) _buildNavCTA(context),
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

  Widget _buildNavCTA(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL('https://wa.me/message/WTBMCUW6NPAQA1'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Style.luxuryGold.withValues(alpha: 0.5)),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                FontAwesomeIcons.whatsapp,
                size: 14,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Text(
                S.of(context).kBetnaHomePageContact,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWhyBetnaSection(BuildContext context, S s) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Container(
      color: const Color(0xFF0F0F0F),
      child: isWide
          ? _buildWhyBetnaWide(context, s)
          : _buildWhyBetnaMobile(context, s),
    );
  }

  Widget _buildWhyBetnaWide(BuildContext context, S s) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left dark panel â€” title
          Expanded(
            flex: 4,
            child: Container(
              color: const Color(0xFF0F0F0F),
              padding: const EdgeInsets.symmetric(
                horizontal: 80,
                vertical: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.kBetnaHomePageWhyBetna,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      height: 0.95,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(width: 48, height: 3, color: Style.luxuryGold),
                  const SizedBox(height: 32),
                  Text(
                    s.kBetnaHomePageWhyBetnaDesc,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 15,
                      height: 1.7,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right white panel â€” stats
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStatRow(
                    context,
                    s.kBetnaHomePageInfoCard1Title,
                    s.kBetnaHomePageInfoCard1Subtitle,
                    '01',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Divider(height: 1),
                  ),
                  _buildStatRow(
                    context,
                    s.kBetnaHomePageInfoCard2Title,
                    s.kBetnaHomePageInfoCard2Subtitle,
                    '02',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Divider(height: 1),
                  ),
                  _buildStatRow(
                    context,
                    s.kBetnaHomePageInfoCard3Title,
                    s.kBetnaHomePageInfoCard3Subtitle,
                    '03',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyBetnaMobile(BuildContext context, S s) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.kBetnaHomePageWhyBetnaRow,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Style.luxuryCharcoal,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Container(width: 40, height: 3, color: Style.luxuryGold),
              const SizedBox(height: 40),
              _buildStatRow(
                context,
                s.kBetnaHomePageInfoCard1Title,
                s.kBetnaHomePageInfoCard1Subtitle,
                '01',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Divider(height: 1),
              ),
              _buildStatRow(
                context,
                s.kBetnaHomePageInfoCard2Title,
                s.kBetnaHomePageInfoCard2Subtitle,
                '02',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Divider(height: 1),
              ),
              _buildStatRow(
                context,
                s.kBetnaHomePageInfoCard3Title,
                s.kBetnaHomePageInfoCard3Subtitle,
                '03',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    String title,
    String subtitle,
    String number,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Style.luxuryGold,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 28),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Style.luxuryCharcoal,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEidsBanner(BuildContext context, S s) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/eids'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        decoration: BoxDecoration(
          color: Style.primaryMaroon.withValues(alpha: 0.06),
          border: Border(
            bottom: BorderSide(
              color: Style.primaryMaroon.withValues(alpha: 0.2),
            ),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Style.primaryMaroon.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Style.primaryMaroon,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.kEidsPageWarning,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        s.kEidsPageSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Style.primaryMaroon,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context, S s) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Container(
      color: Style.luxurySurface,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: isWide ? 80 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.kServicesOurExpertise,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Style.primaryMaroon,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            s.kServicesPremiumServices,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontSize: isWide ? 48 : 32,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 60),
          isWide
              ? Row(
                  children: [
                    Expanded(child: _buildServiceCard(context, s, true)),
                    const SizedBox(width: 48),
                    Expanded(child: _buildServiceCard(context, s, false)),
                  ],
                )
              : Column(
                  children: [
                    _buildServiceCard(context, s, true),
                    const SizedBox(height: 32),
                    _buildServiceCard(context, s, false),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, S s, bool isSales) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Style.luxuryCharcoal,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Style.primaryMaroon.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSales ? Icons.real_estate_agent : Icons.manage_accounts,
              color: Style.primaryMaroon,
              size: 32,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            isSales ? s.kServicesPropertySales : s.kServicesPropertyManagement,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isSales
                ? s.kServicesPropertySalesDesc
                : s.kServicesPropertyManagementDesc,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 15,
              height: 1.7,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 40),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: isSales
                  ? _goToSaleRequest
                  : () => _launchURL('https://wa.me/message/WTBMCUW6NPAQA1'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isSales
                        ? s.kBetnaHomePageSubmitSaleRequest.toUpperCase()
                        : s.kServicesContactUs.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Style.luxuryGold,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.arrow_forward, color: Style.luxuryGold, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€â”€ DYNAMIC FILTERS â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Widget _buildDynamicFilters(BuildContext context, S s) {
    final isWide = MediaQuery.of(context).size.width > 700;
    final propertyProvider = Provider.of<PropertyProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 32, vertical: 40),
      color: Style.luxuryCharcoal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildFilterChip(
                context,
                label: s.kBetnaHomePageFilterAll,
                isActive: propertyProvider.selectedCategory == null,
                onTap: () => propertyProvider.updateFilters(category: null),
              ),
              const SizedBox(width: 12),
              _buildFilterChip(
                context,
                label: s.kBetnaHomePageFilterForSale,
                isActive: propertyProvider.selectedCategory == 'sale',
                onTap: () => propertyProvider.updateFilters(category: 'sale'),
              ),
              const SizedBox(width: 12),
              _buildFilterChip(
                context,
                label: s.kBetnaHomePageFilterProjects,
                isActive: propertyProvider.selectedCategory == 'project',
                onTap: () =>
                    propertyProvider.updateFilters(category: 'project'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              // Location Search
              _buildFilterInput(
                context,
                icon: Icons.search_outlined,
                placeholder: s.kBetnaHomePageFilterLocationHint,
                width: isWide ? 300 : double.infinity,
                onChanged: (val) => propertyProvider.updateFilters(
                  location: val.isEmpty ? null : val,
                ),
              ),
              // Price Filter
              _buildFilterInput(
                context,
                icon: Icons.payments_outlined,
                placeholder: s.kBetnaHomePageFilterMaxPrice,
                width: isWide ? 200 : double.infinity,
                keyboardType: TextInputType.number,
                onChanged: (val) =>
                    propertyProvider.updateFilters(price: double.tryParse(val)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Style.primaryMaroon : Colors.transparent,
          border: Border.all(
            color: isActive
                ? Style.primaryMaroon
                : Colors.white.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.6),
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterInput(
    BuildContext context, {
    required IconData icon,
    required String placeholder,
    required double width,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Style.luxurySurface,
        borderRadius: Corners.medBorder,
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: TextField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.3),
            fontSize: 13,
          ),
          prefixIcon: Icon(icon, color: Style.luxuryGold, size: 18),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  // â”€â”€â”€ PROPERTY SHOWCASE â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Widget _buildPropertyShowcase(BuildContext context, S s) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final propertyProvider = Provider.of<PropertyProvider>(context);

    if (propertyProvider.isLoading && propertyProvider.properties.isEmpty) {
      return _buildShimmerShowcase(context, isWide);
    }

    if (propertyProvider.properties.isEmpty) {
      return Container(
        color: Style.luxuryCharcoal,
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24,
          vertical: 60,
        ),
        child: Center(
          child: Text(
            s.kNoPropertiesMatch,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    // Identify Featured (first) and Others
    final featured = propertyProvider.properties.first;
    final others = propertyProvider.properties.skip(1).toList();

    return Container(
      color: Style.luxuryCharcoal,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: isWide ? 80 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).kBetnaHomePageSelected,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Style.primaryMaroon,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      S.of(context).kBetnaHomePageCollections,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: isWide ? 64 : 36,
                        fontWeight: FontWeight.w900,
                        height: 0.95,
                      ),
                    ),
                  ],
                ),
              ),
              _viewAllButton(context, s),
            ],
          ),
          const SizedBox(height: 48),

          // Inline Filters
          if (propertyProvider.properties.isNotEmpty)
            _buildDynamicFilters(context, s),

          const SizedBox(height: 48),

          // 1. FEATURED CARD
          _buildFeaturedCard(context, featured, isWide),

          const SizedBox(height: 48),

          // 2. GRID OF OTHERS
          if (others.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: others.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWide ? 2 : 1,
                mainAxisSpacing: 48,
                crossAxisSpacing: 48,
                childAspectRatio: isWide ? 1.4 : 1.1,
              ),
              itemBuilder: (context, index) =>
                  _buildPropertyCard(context, others[index], isWide),
            ),
        ],
      ),
    );
  }

  Widget _viewAllButton(BuildContext context, S s) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/resale'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                s.kBetnaHomePageViewAll,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.arrow_right_alt, color: Style.luxuryGold, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerShowcase(BuildContext context, bool isWide) {
    return Container(
      color: Style.luxuryCharcoal,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 32,
        vertical: 100,
      ),
      child: Column(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              color: Style.luxurySurface,
              borderRadius: Corners.lgBorder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(
    BuildContext context,
    PropertyModel property,
    bool isWide,
  ) {
    final lang = Provider.of<MainProvider>(context, listen: false).kLang;
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/property-detail', arguments: property),
      child: _HoverScale(
        child: Container(
          height: isWide ? 600 : 500,
          decoration: BoxDecoration(
            borderRadius: Corners.lgBorder,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: Corners.lgBorder,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildCardImage(property),
                _buildCardOverlay(),
                if (property.isSold)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.4),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Style.primaryMaroon,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            S.of(context).kPropertySold,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 40,
                  left: 40,
                  right: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!property.isSold)
                              _buildCardBadge(
                                context,
                                property.getLocalized(property.tag, lang),
                              ),
                            const SizedBox(height: 20),
                            Text(
                              property.getLocalized(property.title, lang),
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize: isWide ? 52 : 32,
                                    fontWeight: FontWeight.w900,
                                    height: 1.0,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            _buildCardLocation(
                              context,
                              property.getLocalized(property.location, lang),
                            ),
                          ],
                        ),
                      ),
                      if (isWide) _buildCardPrice(context, property),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyCard(
    BuildContext context,
    PropertyModel property,
    bool isWide,
  ) {
    final lang = Provider.of<MainProvider>(context, listen: false).kLang;
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/property-detail', arguments: property),
      child: _HoverScale(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: Corners.lgBorder,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: Corners.lgBorder,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildCardImage(property),
                _buildCardOverlay(),
                if (property.isSold)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.4),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Style.primaryMaroon,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            S.of(context).kPropertySold,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCardBadge(
                        context,
                        property.isSold
                            ? 'SOLD'
                            : property.getLocalized(property.tag, lang),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        property.getLocalized(property.title, lang),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontSize: isWide ? 28 : 22,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildCardLocation(
                        context,
                        property.getLocalized(property.location, lang),
                      ),
                      const SizedBox(height: 16),
                      _buildCardPrice(context, property),
                    ],
                  ),
                ),
                Positioned(top: 24, right: 24, child: _buildArrowButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardImage(PropertyModel property) {
    final bool hasImage =
        property.imageUrl.isNotEmpty || property.images.isNotEmpty;
    if (!hasImage) return Container(color: Style.luxurySurface);

    return CachedNetworkImage(
      imageUrl: property.imageUrl.isNotEmpty
          ? property.imageUrl
          : property.images[0],
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholder: (_, _) => Container(
        color: Style.luxurySurface,
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white24,
          ),
        ),
      ),
      errorWidget: (_, _, _) => Container(color: Style.luxurySurface),
    );
  }

  Widget _buildCardOverlay() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.2, 0.6, 1.0],
            colors: [
              Colors.black.withValues(alpha: 0.1),
              Colors.black.withValues(alpha: 0.4),
              Style.luxuryCharcoal.withValues(alpha: 0.9),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardBadge(BuildContext context, String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Style.primaryMaroon,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        tag.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildCardLocation(BuildContext context, String location) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 14, color: Style.luxuryGold),
        const SizedBox(width: 6),
        Text(
          location.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildCardPrice(BuildContext context, PropertyModel property) {
    final priceStr = property.price.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return Text(
      '${property.currency}$priceStr',
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
        color: Style.luxuryGold,
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildArrowButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
          ),
        ),
      ),
    );
  }

  // â”€â”€â”€ CTA BAND â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Widget _buildCtaBand(BuildContext context, S s) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Container(
      color: Style.primaryMaroon,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 32,
        vertical: isWide ? 80 : 60,
      ),
      child: isWide
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildCtaText(context, s)),
                const SizedBox(width: 64),
                _buildCtaButton(context, s),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCtaText(context, s),
                const SizedBox(height: 40),
                _buildCtaButton(context, s),
              ],
            ),
    );
  }

  Widget _buildCtaText(BuildContext context, S s) {
    final isWide = MediaQuery.of(context).size.width > 700;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).kBetnaHomePageCtaTitle,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Colors.white,
            fontSize: isWide ? 44 : 30,
            fontWeight: FontWeight.w900,
            height: 0.95,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          S.of(context).kBetnaHomePageCtaDesc,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildCtaButton(BuildContext context, S s) {
    return GestureDetector(
      onTap: () => _launchURL('https://wa.me/message/WTBMCUW6NPAQA1'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FontAwesomeIcons.whatsapp,
              size: 18,
              color: Color(0xFF740247),
            ),
            const SizedBox(width: 12),
            Text(
              S.of(context).kBetnaHomePageWhatsappUs,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Style.primaryMaroon,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // â”€â”€â”€ FOOTER â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Widget _buildFooter(BuildContext context, S s) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Container(
      color: const Color(0xFF0A0A0A),
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 32, vertical: 64),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand column
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Logo(hi: 40, we: 120, withBackground: false),
                    const SizedBox(height: 20),
                    Text(
                      S.of(context).kBetnaHomePageFooterDesc,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              if (isWide) ...[
                const Spacer(),
                // Social column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _footerSocialLink(
                      S.of(context).kBetnaHomePageInstagram,
                      FontAwesomeIcons.instagram,
                      'https://www.instagram.com/betnatr/',
                    ),
                    const SizedBox(height: 16),
                    _footerSocialLink(
                      S.of(context).kBetnaHomePageFacebook,
                      FontAwesomeIcons.facebook,
                      'https://www.facebook.com/betnatr',
                    ),
                    const SizedBox(height: 16),
                    _footerSocialLink(
                      S.of(context).kBetnaHomePageWhatsapp,
                      FontAwesomeIcons.whatsapp,
                      'https://wa.me/message/WTBMCUW6NPAQA1',
                    ),
                  ],
                ),
              ],
            ],
          ),
          const SizedBox(height: 64),
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.kBetnaHomePageFooter(DateTime.now().year),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.25),
                  fontSize: 11,
                ),
              ),
              Text(
                '+90 552 533 3666',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.25),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          // Mobile social links
          if (!isWide) ...[
            const SizedBox(height: 32),
            Row(
              children: [
                _footerSocialLink(
                  'IG',
                  FontAwesomeIcons.instagram,
                  'https://www.instagram.com/betnatr/',
                ),
                const SizedBox(width: 24),
                _footerSocialLink(
                  'FB',
                  FontAwesomeIcons.facebook,
                  'https://www.facebook.com/betnatr',
                ),
                const SizedBox(width: 24),
                _footerSocialLink(
                  'WA',
                  FontAwesomeIcons.whatsapp,
                  'https://wa.me/message/WTBMCUW6NPAQA1',
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _footerSocialLink(String label, IconData icon, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.white.withValues(alpha: 0.35)),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// â”€â”€â”€ Hover Scale Widget â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _HoverScale extends StatefulWidget {
  final Widget child;
  const _HoverScale({required this.child});

  @override
  State<_HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<_HoverScale> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.025 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
