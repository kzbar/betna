import 'dart:ui';
import 'package:betna/models/property_model.dart';
import 'package:betna/style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:betna/providers/main_provider.dart';

class PropertyDetailPage extends StatefulWidget {
  final PropertyModel property;

  const PropertyDetailPage({super.key, required this.property});

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  final ScrollController _scrollController = ScrollController();

  static const Map<String, IconData> _amenityIcons = {
    'Swimming Pool': Icons.pool,
    'Gym / Fitness': Icons.fitness_center,
    '24/7 Security': Icons.security,
    'Parking': Icons.local_parking,
    'Sauna / Turkish Bath': Icons.hot_tub,
    'Children\'s Playground': Icons.child_care,
    'Smart Home System': Icons.home_max,
    'Sea View': Icons.waves,
    'City View': Icons.location_city,
    'Garden': Icons.yard,
  };

  List<String> get _allImages => [
    if (widget.property.imageUrl.isNotEmpty) widget.property.imageUrl,
    ...widget.property.images,
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _contactWhatsApp(String lang) async {
    final title = widget.property.getLocalized(widget.property.title, lang);
    final message = lang == 'ar'
        ? "مرحباً، أنا مهتم بهذا العقار: $title (ID: ${widget.property.id})"
        : lang == 'tr'
        ? "Merhaba, bu mülkle ilgileniyorum: $title (ID: ${widget.property.id})"
        : "Hello, I am interested in this property: $title (ID: ${widget.property.id})";
    final url =
        "https://wa.me/905525333666?text=${Uri.encodeComponent(message)}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _openFullScreenGallery(int initialIndex) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) =>
            _FullScreenGallery(images: _allImages, initialIndex: initialIndex),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<MainProvider>(context, listen: false).kLang;
    final isMobile = MediaQuery.of(context).size.width < 700;
    final prop = widget.property;

    return Scaffold(
      backgroundColor: Style.luxuryCharcoal,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // ── Hero Image Gallery ──
              SliverToBoxAdapter(child: _buildHeroGallery(isMobile)),

              // ── Content Body ──
              SliverToBoxAdapter(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 900),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 40,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Price Header
                      _buildHeader(lang, isMobile, prop),
                      const SizedBox(height: 28),

                      // Quick Specs Row
                      _buildSpecsStrip(lang, prop),
                      const SizedBox(height: 32),

                      // Description
                      if (prop.description.isNotEmpty) ...[
                        _buildSectionTitle("Description"),
                        const SizedBox(height: 14),
                        Text(
                          prop.getLocalized(prop.description, lang),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 15,
                            height: 1.7,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 36),
                      ],

                      // Amenities
                      if (prop.amenities.isNotEmpty) ...[
                        _buildSectionTitle("Amenities"),
                        const SizedBox(height: 16),
                        _buildAmenities(prop),
                        const SizedBox(height: 36),
                      ],

                      // Video Tour
                      if (prop.videoUrl.isNotEmpty) ...[
                        _buildSectionTitle("Property Tour"),
                        const SizedBox(height: 16),
                        _buildVideoButton(prop),
                        const SizedBox(height: 36),
                      ],

                      // All Images Grid
                      if (_allImages.length > 1) ...[
                        _buildSectionTitle("Gallery"),
                        const SizedBox(height: 16),
                        _buildImageGrid(),
                        const SizedBox(height: 36),
                      ],

                      const SizedBox(height: 80), // space for bottom bar
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Floating Back Button ──
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: _buildFloatingBackButton(),
          ),

          // ── Bottom CTA ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomCTA(lang),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  // Hero Gallery - Full Width
  // ──────────────────────────────────────────
  Widget _buildHeroGallery(bool isMobile) {
    final heroHeight = isMobile ? 360.0 : 500.0;

    if (_allImages.isEmpty) {
      return Container(
        height: heroHeight,
        color: Style.luxurySurface,
        child: const Center(
          child: Icon(
            Icons.image_not_supported,
            color: Colors.white24,
            size: 64,
          ),
        ),
      );
    }

    return SizedBox(
      height: heroHeight,
      child: Stack(
        children: [
          // Page View - ScrollConfiguration enables mouse drag on desktop/web
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
              },
            ),
            child: PageView.builder(
              controller: _pageController,
              itemCount: _allImages.length,
              onPageChanged: (i) => setState(() => _currentImageIndex = i),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _openFullScreenGallery(index),
                  child: CachedNetworkImage(
                    imageUrl: _allImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (_, __) => Container(
                      color: Style.luxurySurface,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: Style.luxurySurface,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white24,
                        size: 48,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 120,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Style.luxuryCharcoal.withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
          ),

          // Image Counter + Dots
          if (_allImages.length > 1)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_allImages.length, (i) {
                      final isActive = i == _currentImageIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isActive ? 24 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: isActive
                              ? Style.luxuryGold
                              : Colors.white.withValues(alpha: 0.35),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  // Counter badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${_currentImageIndex + 1} / ${_allImages.length}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Tap to expand hint
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: GestureDetector(
              onTap: () => _openFullScreenGallery(_currentImageIndex),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.fullscreen, color: Colors.white70, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "View",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  // Header: Title, Location, Price
  // ──────────────────────────────────────────
  Widget _buildHeader(String lang, bool isMobile, PropertyModel prop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tag + Sold badge
        Row(
          children: [
            if (prop.tag.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Style.luxuryGold,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  prop.getLocalized(prop.tag, lang).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            if (prop.isSold) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.red[800],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "SOLD",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
            if (prop.isInstallmentAvailable) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "INSTALLMENT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),

        // Title
        Text(
          prop.getLocalized(prop.title, lang),
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 10),

        // Location
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Style.primaryMaroon,
              size: 18,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                prop.getLocalized(prop.location, lang),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Price
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Style.luxuryGold.withValues(alpha: 0.15),
                Style.luxuryGold.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Style.luxuryGold.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.payments_outlined, color: Style.luxuryGold, size: 22),
              const SizedBox(width: 12),
              Text(
                "${prop.currency} ${_formatPrice(prop.price)}",
                style: TextStyle(
                  color: Style.luxuryGold,
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return "${(price / 1000000).toStringAsFixed(price % 1000000 == 0 ? 0 : 1)}M";
    }
    if (price >= 1000) {
      return "${(price / 1000).toStringAsFixed(price % 1000 == 0 ? 0 : 1)}K";
    }
    return price.toInt().toString();
  }

  // ──────────────────────────────────────────
  // Specs Strip
  // ──────────────────────────────────────────
  Widget _buildSpecsStrip(String lang, PropertyModel prop) {
    final specs = <_SpecData>[
      if (prop.rooms.isNotEmpty)
        _SpecData(
          Icons.bed_outlined,
          "Rooms",
          prop.getLocalized(prop.rooms, lang),
        ),
      if (prop.area > 0)
        _SpecData(
          Icons.square_foot_outlined,
          "Area",
          "${prop.area.toInt()} m²",
        ),
      if (prop.floor.isNotEmpty)
        _SpecData(
          Icons.layers_outlined,
          "Floor",
          prop.getLocalized(prop.floor, lang),
        ),
      if (prop.age.isNotEmpty)
        _SpecData(
          Icons.schedule_outlined,
          "Age",
          prop.getLocalized(prop.age, lang),
        ),
      if (prop.developer.isNotEmpty)
        _SpecData(
          Icons.business_outlined,
          "Developer",
          prop.getLocalized(prop.developer, lang),
        ),
      if (prop.status.isNotEmpty)
        _SpecData(
          Icons.info_outline,
          "Status",
          prop.getLocalized(prop.status, lang),
        ),
    ];

    if (specs.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Style.luxurySurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: specs.map((spec) {
          return Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  Icon(spec.icon, color: Style.primaryMaroon, size: 22),
                  const SizedBox(height: 8),
                  Text(
                    spec.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    spec.label,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ──────────────────────────────────────────
  // Amenities
  // ──────────────────────────────────────────
  Widget _buildAmenities(PropertyModel prop) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: prop.amenities.map((amenity) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Style.luxurySurface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _amenityIcons[amenity] ?? Icons.check_circle_outline,
                color: Style.luxuryGold,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                amenity,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ──────────────────────────────────────────
  // Video Button
  // ──────────────────────────────────────────
  Widget _buildVideoButton(PropertyModel prop) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(prop.videoUrl)),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              colors: [
                Colors.red.withValues(alpha: 0.15),
                Colors.red.withValues(alpha: 0.05),
              ],
            ),
            border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_fill_rounded,
                color: Colors.redAccent,
                size: 28,
              ),
              SizedBox(width: 12),
              Text(
                "WATCH VIDEO TOUR",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────
  // Image Grid
  // ──────────────────────────────────────────
  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemCount: _allImages.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _openFullScreenGallery(index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: _allImages[index],
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: Style.luxurySurface),
              errorWidget: (_, __, ___) => Container(
                color: Style.luxurySurface,
                child: const Icon(Icons.broken_image, color: Colors.white24),
              ),
            ),
          ),
        );
      },
    );
  }

  // ──────────────────────────────────────────
  // Section Title
  // ──────────────────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: Style.primaryMaroon,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────
  // Floating Back Button
  // ──────────────────────────────────────────
  Widget _buildFloatingBackButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────
  // Bottom WhatsApp CTA
  // ──────────────────────────────────────────
  Widget _buildBottomCTA(String lang) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            MediaQuery.of(context).padding.bottom + 16,
          ),
          decoration: BoxDecoration(
            color: Style.luxuryCharcoal.withValues(alpha: 0.85),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
            ),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () => _contactWhatsApp(lang),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.whatsapp, size: 22),
                    SizedBox(width: 12),
                    Text(
                      "CONTACT AGENT",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────
// Spec Data Helper
// ──────────────────────────────────────────
class _SpecData {
  final IconData icon;
  final String label;
  final String value;
  const _SpecData(this.icon, this.label, this.value);
}

// ──────────────────────────────────────────
// Full Screen Gallery
// ──────────────────────────────────────────
class _FullScreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenGallery({required this.images, required this.initialIndex});

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery> {
  late PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Swipeable Images
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.images[index],
                    fit: BoxFit.contain,
                    width: double.infinity,
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white24,
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Icon(
                      Icons.broken_image,
                      color: Colors.white24,
                      size: 48,
                    ),
                  ),
                ),
              );
            },
          ),

          // Close button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black45,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),

          // Counter
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${_currentIndex + 1} / ${widget.images.length}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
