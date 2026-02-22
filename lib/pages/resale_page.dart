import 'package:betna/generated/l10n.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/logo_widget.dart';
import 'package:betna/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:betna/setup/enumerators.dart';
import 'dart:ui';
import 'package:betna/widgets/home/mobile_drawer.dart';
import 'package:betna/providers/property_provider.dart';
import 'package:betna/models/property_model.dart';

class ResalePage extends StatefulWidget {
  const ResalePage({super.key});

  @override
  State<ResalePage> createState() => _ResalePageState();
}

class _ResalePageState extends State<ResalePage> {
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

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isMobile = MediaQuery.of(context).size.width <= 700;

    return Scaffold(
      backgroundColor: Style.luxuryCharcoal,
      endDrawer: const MobileDrawer(),
      body: Stack(
        children: [
          // Background Gradient
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

          // Main Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Spacer for Navbar
              SliverToBoxAdapter(child: SizedBox(height: isMobile ? 80 : 100)),

              // Header Section
              SliverToBoxAdapter(
                child: _buildHeaderConfig(context, s, isMobile),
              ),

              // Grid of Resale Properties
              Consumer<PropertyProvider>(
                builder: (context, provider, child) {
                  final resaleItems = provider.properties
                      .where((p) => p.category == 'resale')
                      .toList();

                  if (provider.isLoading && resaleItems.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Style.primaryMaroon,
                        ),
                      ),
                    );
                  }

                  if (resaleItems.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          "No properties found in this category",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 80,
                      vertical: 40,
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 1 : 3,
                        childAspectRatio: isMobile ? 1.0 : 0.85,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 40,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return _buildResaleCard(
                          context,
                          resaleItems[index],
                          isMobile,
                        );
                      }, childCount: resaleItems.length),
                    ),
                  );
                },
              ),

              // Footer
              SliverToBoxAdapter(child: _buildFooter(context, s)),
            ],
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

  Widget _buildHeaderConfig(BuildContext context, S s, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
              s.kResaleSectionTitle.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Style.primaryMaroon,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            s.kResaleSectionText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: isMobile ? 24 : 42,
              height: 1.2,

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

  Widget _buildResaleCard(
    BuildContext context,
    PropertyModel property,
    bool isMobile,
  ) {
    final lang = Provider.of<MainProvider>(context, listen: false).kLang;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          '/property-detail',
          arguments: property,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Style.luxurySurface,
              border: Border.all(color: Style.border.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Placeholder Area
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (property.imageUrl.isNotEmpty ||
                          property.images.isNotEmpty)
                        Image.network(
                          property.imageUrl.isNotEmpty
                              ? property.imageUrl
                              : property.images[0],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(color: Colors.grey[900]);
                          },
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Style.primaryMaroon.withValues(alpha: 0.3),
                                Style.luxuryCharcoal.withValues(alpha: 0.8),
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                          ),
                        ),
                      if (property.imageUrl.isEmpty && property.images.isEmpty)
                        Center(
                          child: Opacity(
                            opacity: 0.15,
                            child: Logo(hi: 50, we: 120, withBackground: false),
                          ),
                        ),
                      // Sold Badge
                      if (property.isSold)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.5),
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
                                  "SOLD",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      // Tag Badge
                      if (property.tag.isNotEmpty && !property.isSold)
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Style.primaryMaroon,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              property
                                  .getLocalized(property.tag, lang)
                                  .toUpperCase(),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Info Area
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              property.getLocalized(property.title, lang),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize: isMobile ? 16 : 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            if (property.description.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  property.getLocalized(
                                    property.description,
                                    lang,
                                  ),
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            Row(
                              children: [
                                Icon(
                                  Icons.bed,
                                  color: Style.primaryMaroon,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  property.getLocalized(property.rooms, lang),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                      ),
                                ),
                                const SizedBox(width: 16),
                                Icon(
                                  Icons.square_foot,
                                  color: Style.primaryMaroon,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${property.area.toInt()} m2",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${property.currency} ${property.price.toInt()}",
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: Style.luxuryGold,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Common navbar component extracted for consistency
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
      child: Center(
        child: Column(
          children: [
            Logo(hi: 45, we: 120, withBackground: false),
            const SizedBox(height: 24),
            Text(
              "© ${DateTime.now().year} Betna Gayrimenkul. All rights reserved.",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
