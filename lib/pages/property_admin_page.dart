import 'package:betna/models/property_model.dart';
import 'package:betna/providers/main_provider.dart';
import 'package:betna/providers/property_provider.dart';
import 'package:betna/services/firebase_collections_names.dart';
import 'package:betna/services/firebase_methods.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/logo_widget.dart';
import 'package:betna/services/translation_service.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:betna/services/firebase_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class PropertyAdminPage extends StatefulWidget {
  const PropertyAdminPage({super.key});

  @override
  State<PropertyAdminPage> createState() => _PropertyAdminPageState();
}

class _PropertyAdminPageState extends State<PropertyAdminPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoggedIn = false;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkLogin() async {
    // Simple private password check for demonstration
    // In production, this should use Firebase Auth roles
    if (_passwordController.text == "BetnaAdmin2026") {
      try {
        await FirebaseAuth.instance.signInAnonymously();
        setState(() {
          _isLoggedIn = true;
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Auth Error: $e")));
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Incorrect Admin Key")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedIn) {
      return _buildLoginOverlay();
    }

    return Scaffold(
      backgroundColor: Style.luxuryCharcoal,
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPropertySection(
            FirebaseCollectionNames.ResaleCollection,
            "resale",
          ),
          _buildPropertySection(
            FirebaseCollectionNames.ProjectsCollection,
            "project",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPropertyForm(),
        backgroundColor: Style.primaryMaroon,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "ADD OFFER",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLoginOverlay() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(40),
          decoration: Style.glassBox(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Logo(hi: 60, we: 150, withBackground: false),
              const SizedBox(height: 40),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Admin Key",
                  labelStyle: const TextStyle(color: Colors.white60),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Style.luxuryGold),
                  ),
                ),
                onSubmitted: (_) => _checkLogin(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _checkLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Style.primaryMaroon,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "ACCESS DASHBOARD",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text(
        "PROPERTIES ADMIN",
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 2,
          fontWeight: FontWeight.w900,
        ),
      ),
      centerTitle: true,
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Style.luxuryGold,
        labelColor: Style.luxuryGold,
        unselectedLabelColor: Colors.white60,
        tabs: const [
          Tab(text: "RESALE"),
          Tab(text: "PROJECTS"),
        ],
      ),
    );
  }

  Widget _buildPropertySection(String collection, String category) {
    return Consumer<PropertyProvider>(
      builder: (context, provider, child) {
        final lang = Provider.of<MainProvider>(context, listen: false).kLang;
        final items = provider.properties
            .where((p) => p.category == category)
            .toList();

        if (items.isEmpty) {
          return Center(
            child: Text(
              "No $category offers yet.",
              style: const TextStyle(color: Colors.white38),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final property = items[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: property.imageUrl.isNotEmpty
                        ? Image.network(
                            property.imageUrl,
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.grey[900],
                            width: 80,
                            height: 60,
                          ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.getLocalized(property.title, lang),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${property.rooms} | ${property.area}m2 | ${property.price} ${property.currency}",
                          style: TextStyle(
                            color: property.isSold
                                ? Colors.red
                                : Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () => _showPropertyForm(property: property),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _deleteProperty(collection, property.id),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _deleteProperty(String collection, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Property?"),
        content: const Text("This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("CANCEL"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("DELETE", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseMethod.delete(co: collection, doc: id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Property deleted")));
    }
  }

  void _showPropertyForm({PropertyModel? property}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PropertyForm(property: property),
    );
  }
}

class _PropertyForm extends StatefulWidget {
  final PropertyModel? property;
  const _PropertyForm({this.property});

  @override
  State<_PropertyForm> createState() => _PropertyFormState();
}

class _PropertyFormState extends State<_PropertyForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TabController _langTabController;

  final Map<String, TextEditingController> _titleControllers = {
    'en': TextEditingController(),
    'tr': TextEditingController(),
    'ar': TextEditingController(),
  };
  final Map<String, TextEditingController> _locationControllers = {
    'en': TextEditingController(),
    'tr': TextEditingController(),
    'ar': TextEditingController(),
  };
  final Map<String, TextEditingController> _tagControllers = {
    'en': TextEditingController(),
    'tr': TextEditingController(),
    'ar': TextEditingController(),
  };
  final Map<String, TextEditingController> _roomsControllers = {
    'en': TextEditingController(),
    'tr': TextEditingController(),
    'ar': TextEditingController(),
  };
  final Map<String, TextEditingController> _floorControllers = {
    'en': TextEditingController(),
    'tr': TextEditingController(),
    'ar': TextEditingController(),
  };
  final Map<String, TextEditingController> _ageControllers = {
    'en': TextEditingController(),
    'tr': TextEditingController(),
    'ar': TextEditingController(),
  };
  final Map<String, TextEditingController> _developerControllers = {
    'en': TextEditingController(),
    'tr': TextEditingController(),
    'ar': TextEditingController(),
  };
  final Map<String, TextEditingController> _statusControllers = {
    'en': TextEditingController(),
    'tr': TextEditingController(),
    'ar': TextEditingController(),
  };
  final Map<String, TextEditingController> _deliveryDateControllers = {
    'en': TextEditingController(),
    'tr': TextEditingController(),
    'ar': TextEditingController(),
  };
  final Map<String, TextEditingController> _descriptionControllers = {
    'en': TextEditingController(),
    'tr': TextEditingController(),
    'ar': TextEditingController(),
  };

  static const Map<String, Map<String, String>> _roomOptions = {
    'studio': {'en': 'Studio', 'tr': 'Stüdyo', 'ar': 'استوديو'},
    '1+1': {'en': '1+1', 'tr': '1+1', 'ar': '1+1'},
    '2+1': {'en': '2+1', 'tr': '2+1', 'ar': '2+1'},
    '3+1': {'en': '3+1', 'tr': '3+1', 'ar': '3+1'},
    '4+1': {'en': '4+1', 'tr': '4+1', 'ar': '4+1'},
    '5+1': {'en': '5+1', 'tr': '5+1', 'ar': '5+1'},
    'villa': {'en': 'Villa', 'tr': 'Villa', 'ar': 'فيلا'},
  };

  static const Map<String, Map<String, String>> _statusOptions = {
    'under_construction': {
      'en': 'Under Construction',
      'tr': 'İnşaat Halinde',
      'ar': 'قيد الإنشاء',
    },
    'ready': {'en': 'Ready', 'tr': 'Hazır', 'ar': 'جاهز'},
    'off_plan': {
      'en': 'Off-plan',
      'tr': 'Proje Aşamasında',
      'ar': 'على المخطط',
    },
  };

  static const Map<String, Map<String, String>> _ageOptions = {
    '0': {'en': '0 (New)', 'tr': '0 (Yeni)', 'ar': '0 (جديد)'},
    '1-5': {'en': '1-5 Years', 'tr': '1-5 Yıl', 'ar': '1-5 سنوات'},
    '5-10': {'en': '5-10 Years', 'tr': '5-10 Yıl', 'ar': '5-10 سنوات'},
    '10+': {'en': '10+ Years', 'tr': '10+ Yıl', 'ar': '10+ سنوات'},
  };

  static const Map<String, Map<String, String>> _tagOptions = {
    'new': {'en': 'NEW', 'tr': 'YENİ', 'ar': 'جديد'},
    'hot': {'en': 'HOT DEAL', 'tr': 'SICAK FIRSAT', 'ar': 'عرض ساخن'},
    'investment': {'en': 'INVESTMENT', 'tr': 'YATIRIM', 'ar': 'استثمار'},
    'luxury': {'en': 'LUXURY', 'tr': 'LÜKS', 'ar': 'فاخر'},
  };

  static final Map<String, Map<String, String>> _floorOptions = {
    for (var e in List.generate(41, (i) => i.toString()))
      e: {'en': e, 'tr': e, 'ar': e},
  };

  static final Map<String, String> _currencyOptions = {
    'USD': 'USD',
    'TRY': 'TRY',
    'EUR': 'EUR',
  };

  static const List<String> _amenityOptions = [
    'Swimming Pool',
    'Gym / Fitness',
    '24/7 Security',
    'Parking',
    'Sauna / Turkish Bath',
    'Children\'s Playground',
    'Smart Home System',
    'Sea View',
    'City View',
    'Garden',
  ];

  late TextEditingController _priceController;
  late TextEditingController _areaController;
  late TextEditingController _imageUrlController;
  late TextEditingController _videoUrlController;

  late String _category;
  late String _currency;
  late bool _isSold;
  late bool _isInstallmentAvailable;
  List<String> _selectedAmenities = [];
  bool _isUploading = false;
  bool _isTranslating = false;
  final List<XFile> _localSelectedImages = [];

  Map<String, String> collect(Map<String, TextEditingController> m) {
    return m.map((k, v) => MapEntry(k, v.text.trim()));
  }

  @override
  void initState() {
    super.initState();
    _langTabController = TabController(length: 3, vsync: this);

    _priceController = TextEditingController(
      text: (widget.property?.price ?? 0).toString(),
    );
    _areaController = TextEditingController(
      text: (widget.property?.area ?? 0).toString(),
    );
    _imageUrlController = TextEditingController(
      text: widget.property?.imageUrl ?? "",
    );
    _videoUrlController = TextEditingController(
      text: widget.property?.videoUrl ?? "",
    );

    _category = widget.property?.category ?? "resale";
    _currency = widget.property?.currency ?? "USD";
    _isSold = widget.property?.isSold ?? false;
    _isInstallmentAvailable = widget.property?.isInstallmentAvailable ?? false;
    _selectedAmenities = List<String>.from(widget.property?.amenities ?? []);

    // Initialize controllers with existing data
    final p = widget.property;
    if (p != null) {
      for (var lang in ['en', 'tr', 'ar']) {
        _titleControllers[lang]!.text = p.title[lang] ?? "";
        _locationControllers[lang]!.text = p.location[lang] ?? "";
        _tagControllers[lang]!.text = p.tag[lang] ?? "";
        _roomsControllers[lang]!.text = p.rooms[lang] ?? "";
        _floorControllers[lang]!.text = p.floor[lang] ?? "";
        _ageControllers[lang]!.text = p.age[lang] ?? "";
        _developerControllers[lang]!.text = p.developer[lang] ?? "";
        _statusControllers[lang]!.text = p.status[lang] ?? "";
        _deliveryDateControllers[lang]!.text = p.deliveryDate[lang] ?? "";
        _descriptionControllers[lang]!.text = p.description[lang] ?? "";
      }
    } else {
      // Default tags
      _tagControllers['en']!.text = "NEW";
      _tagControllers['tr']!.text = "YENİ";
      _tagControllers['ar']!.text = "جديد";
    }
  }

  @override
  void dispose() {
    _langTabController.dispose();
    _priceController.dispose();
    _areaController.dispose();
    _imageUrlController.dispose();
    _videoUrlController.dispose();
    for (var c in _titleControllers.values) {
      c.dispose();
    }
    for (var c in _locationControllers.values) {
      c.dispose();
    }
    for (var c in _tagControllers.values) {
      c.dispose();
    }
    for (var c in _roomsControllers.values) {
      c.dispose();
    }
    for (var c in _floorControllers.values) {
      c.dispose();
    }
    for (var c in _ageControllers.values) {
      c.dispose();
    }
    for (var c in _statusControllers.values) {
      c.dispose();
    }
    for (var c in _deliveryDateControllers.values) {
      c.dispose();
    }
    for (var c in _descriptionControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  bool _validateTranslations() {
    for (var lang in ['en', 'tr', 'ar']) {
      if (_titleControllers[lang]!.text.trim().isEmpty ||
          _locationControllers[lang]!.text.trim().isEmpty) {
        return false;
      }
    }
    return true;
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // 1. Requirement: Mandatory Translation Check
      if (!_validateTranslations()) {
        final proceed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Style.luxurySurface,
            title: const Text(
              "Missing Translations",
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              "Title and Location must be filled in EN, TR, and AR before saving. Would you like to auto-fill them now?",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("CANCEL"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Style.primaryMaroon,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  "AUTO-FILL",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );

        if (proceed == true) {
          await _translateAll();
          if (!_validateTranslations()) return; // Still empty? STOP.
        } else {
          return;
        }
      }

      // 2. Requirement: ID Generation for Folder
      final String docId =
          widget.property?.id ??
          DateTime.now().millisecondsSinceEpoch.toString();
      final String folderName = "properties/$docId";

      final data = {
        'title': collect(_titleControllers),
        'price': double.tryParse(_priceController.text) ?? 0,
        'location': collect(_locationControllers),
        'currency': _currency,
        'rooms': collect(_roomsControllers),
        'area': double.tryParse(_areaController.text) ?? 0,
        'category': _category,
        'imageUrl': _imageUrlController.text,
        'images': [],
        'isSold': _isSold,
        'floor': collect(_floorControllers),
        'age': collect(_ageControllers),
        'developer': collect(_developerControllers),
        'status': collect(_statusControllers),
        'deliveryDate': collect(_deliveryDateControllers),
        'isInstallmentAvailable': _isInstallmentAvailable,
        'tag': collect(_tagControllers),
        'description': collect(_descriptionControllers),
        'amenities': _selectedAmenities,
        'videoUrl': _videoUrlController.text.trim(),
        'createdAt': widget.property?.createdAt ?? Timestamp.now(),
      };

      String collection = FirebaseCollectionNames.ResaleCollection;
      if (_category == 'project') {
        collection = FirebaseCollectionNames.ProjectsCollection;
      }

      setState(() => _isUploading = true);
      try {
        // 3. Requirement: Multi-Image Upload to specific folder
        final List<String> finalUrls = [];

        // Handle all local images
        for (int i = 0; i < _localSelectedImages.length; i++) {
          final file = _localSelectedImages[i];
          final uploadedUrl = await FirebaseStorageService.uploadPropertyImage(
            file,
            fileName: "image_$i.jpg",
            folder: folderName,
          );
          if (uploadedUrl == null) throw "Image upload failed for index $i";
          finalUrls.add(uploadedUrl);
        }

        // Handle existing remote URLs (if any were kept)
        String currentImageUrl = _imageUrlController.text.trim();
        if (currentImageUrl.startsWith("http") &&
            !finalUrls.contains(currentImageUrl)) {
          finalUrls.insert(0, currentImageUrl);
        }

        if (finalUrls.isNotEmpty) {
          data['imageUrl'] = finalUrls.first;
          data['images'] = finalUrls.length > 1 ? finalUrls.sublist(1) : [];
        }

        if (widget.property != null) {
          await FirebaseMethod.update(co: collection, doc: docId, value: data);
        } else {
          await FirebaseMethod.add(co: collection, doc: docId, value: data);
        }

        Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error saving property: $e")));
        }
      } finally {
        if (mounted) setState(() => _isUploading = false);
      }
    }
  }

  Future<void> _translateAll() async {
    setState(() => _isTranslating = true);
    try {
      final sourceLang = ['en', 'tr', 'ar'][_langTabController.index];
      final targetLangs = [
        'en',
        'tr',
        'ar',
      ].where((l) => l != sourceLang).toList();

      final List<Map<String, TextEditingController>> fieldMaps = [
        _titleControllers,
        _locationControllers,
        _tagControllers,
        _roomsControllers,
        _floorControllers,
        _ageControllers,
        _developerControllers,
        _statusControllers,
        _deliveryDateControllers,
        _descriptionControllers,
      ];

      for (var controllers in fieldMaps) {
        String sourceText = controllers[sourceLang]!.text;
        if (sourceText.isNotEmpty) {
          for (var targetLang in targetLangs) {
            String translated = await TranslationService.translate(
              sourceText,
              targetLang,
            );
            controllers[targetLang]!.text = translated;
          }
        }
      }
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Translation complete")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Translation failed: $e")));
      }
    } finally {
      if (mounted) {
        setState(() => _isTranslating = false);
      }
    }
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> pickedFiles =
          await FirebaseStorageService.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        setState(() {
          _localSelectedImages.addAll(pickedFiles);
          if (_imageUrlController.text.trim().isEmpty) {
            _imageUrlController.text = pickedFiles.first.path;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error picking images: $e")));
      }
    }
  }

  Widget _buildImagePreview() {
    if (_localSelectedImages.isEmpty && _imageUrlController.text.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Selected Media",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // Local Images
                ..._localSelectedImages.map(
                  (file) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: kIsWeb
                                ? Image.network(file.path, fit: BoxFit.cover)
                                : Image.file(
                                    File(file.path),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: InkWell(
                            onTap: () => setState(() {
                              _localSelectedImages.remove(file);
                              if (_imageUrlController.text == file.path) {
                                _imageUrlController.clear();
                              }
                            }),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Remote Image (if any)
                if (_imageUrlController.text.startsWith('http'))
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _imageUrlController.text,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Style.luxuryCharcoal,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.property == null ? "NEW OFFER" : "EDIT OFFER",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildControllerField(
                      "Price",
                      _priceController,
                      (_) {},
                      isNum: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: DropdownButtonFormField<String>(
                        value: _currency,
                        decoration: const InputDecoration(
                          labelText: "Currency",
                          labelStyle: TextStyle(color: Colors.white60),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white24),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        dropdownColor: Style.luxuryCharcoal,
                        style: const TextStyle(color: Colors.white),
                        items: _currencyOptions.keys.map((curr) {
                          return DropdownMenuItem(
                            value: curr,
                            child: Text("$curr (${_currencyOptions[curr]})"),
                          );
                        }).toList(),
                        onChanged: (v) => setState(() => _currency = v!),
                      ),
                    ),
                  ),
                ],
              ),
              _buildControllerField(
                "Area (m2)",
                _areaController,
                (_) {},
                isNum: true,
              ),
              const Divider(color: Colors.white24, height: 40),

              // Language Tabs
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      controller: _langTabController,
                      indicatorColor: Style.luxuryGold,
                      tabs: const [
                        Tab(text: "EN"),
                        Tab(text: "TR"),
                        Tab(text: "AR"),
                      ],
                    ),
                  ),
                  _isTranslating
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : TextButton.icon(
                          onPressed: _translateAll,
                          icon: const Icon(Icons.translate, size: 16),
                          label: const Text("AUTO-FILL OTHERS"),
                          style: TextButton.styleFrom(
                            foregroundColor: Style.luxuryGold,
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 24),

              SizedBox(
                height: 550, // Increased height for description field
                child: TabBarView(
                  controller: _langTabController,
                  children: [
                    _buildLanguageFields('en'),
                    _buildLanguageFields('tr'),
                    _buildLanguageFields('ar'),
                  ],
                ),
              ),

              const Divider(color: Colors.white24, height: 40),

              _buildImagePreview(),

              Row(
                children: [
                  Expanded(
                    child: _buildControllerField(
                      "Main Image URL",
                      _imageUrlController,
                      (_) => setState(() {}),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.upload, color: Style.luxuryGold),
                    onPressed: _pickImages,
                  ),
                ],
              ),
              _buildControllerField(
                "Video URL (YouTube/Vimeo)",
                _videoUrlController,
                (_) => setState(() {}),
              ),

              const Text(
                "Amenities",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _amenityOptions.map((amenity) {
                  final isSelected = _selectedAmenities.contains(amenity);
                  return FilterChip(
                    label: Text(
                      amenity,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedAmenities.add(amenity);
                        } else {
                          _selectedAmenities.remove(amenity);
                        }
                      });
                    },
                    selectedColor: Style.luxuryGold,
                    backgroundColor: Style.luxurySurface,
                    checkmarkColor: Colors.black,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              if (_isUploading) const LinearProgressIndicator(),

              DropdownButtonFormField<String>(
                value: _category,
                dropdownColor: Style.luxuryCharcoal,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Category",
                  labelStyle: TextStyle(color: Colors.white60),
                ),
                items: ["resale", "project"]
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(c.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
              ),

              SwitchListTile(
                title: const Text(
                  "MARK AS SOLD",
                  style: TextStyle(color: Colors.white),
                ),
                value: _isSold,
                activeThumbColor: Style.primaryMaroon,
                onChanged: (v) => setState(() => _isSold = v),
              ),

              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Style.primaryMaroon,
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text(
                  "SAVE PROPERTY",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageFields(String lang) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildControllerField(
            "Title ($lang)",
            _titleControllers[lang]!,
            (_) {},
          ),
          _buildControllerField(
            "Location ($lang)",
            _locationControllers[lang]!,
            (_) {},
          ),
          _buildControllerField(
            "Description ($lang)",
            _descriptionControllers[lang]!,
            (_) {},
            maxLines: 5,
          ),
          _buildDropdownField(
            label: "Tag ($lang)",
            currentValue: _tagControllers[lang]!.text,
            optionsMap: _tagOptions,
            lang: lang,
            controllers: _tagControllers,
          ),
          Row(
            children: [
              Expanded(
                child: _buildDropdownField(
                  label: "Rooms ($lang)",
                  currentValue: _roomsControllers[lang]!.text,
                  optionsMap: _roomOptions,
                  lang: lang,
                  controllers: _roomsControllers,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdownField(
                  label: "Floor ($lang)",
                  currentValue: _floorControllers[lang]!.text,
                  optionsMap: _floorOptions,
                  lang: lang,
                  controllers: _floorControllers,
                ),
              ),
            ],
          ),
          _buildDropdownField(
            label: "Age ($lang)",
            currentValue: _ageControllers[lang]!.text,
            optionsMap: _ageOptions,
            lang: lang,
            controllers: _ageControllers,
          ),
          if (_category == 'project') ...[
            _buildControllerField(
              "Developer ($lang)",
              _developerControllers[lang]!,
              (_) {},
            ),
            _buildDropdownField(
              label: "Status ($lang)",
              currentValue: _statusControllers[lang]!.text,
              optionsMap: _statusOptions,
              lang: lang,
              controllers: _statusControllers,
            ),
            _buildControllerField(
              "Delivery Date ($lang)",
              _deliveryDateControllers[lang]!,
              (_) {},
            ),
            SwitchListTile(
              title: const Text(
                "Installment Available",
                style: TextStyle(color: Colors.white),
              ),
              contentPadding: EdgeInsets.zero,
              value: _isInstallmentAvailable,
              activeColor: Style.luxuryGold,
              onChanged: (v) => setState(() => _isInstallmentAvailable = v),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildControllerField(
    String label,
    TextEditingController controller,
    Function(String) onSave, {
    bool isNum = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        keyboardType: isNum ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white60),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onChanged: onSave,
        validator: (v) => v!.isEmpty ? "Required" : null,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String currentValue,
    required Map<String, Map<String, String>> optionsMap,
    required String lang,
    required Map<String, TextEditingController> controllers,
  }) {
    final options = optionsMap.values.map((v) => v[lang]!).toList();

    // Ensure currentValue is valid or null
    String? selectedValue;
    if (options.contains(currentValue)) {
      selectedValue = currentValue;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white60),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        dropdownColor: Style.luxuryCharcoal,
        style: const TextStyle(color: Colors.white),
        items: options.map((opt) {
          return DropdownMenuItem(value: opt, child: Text(opt));
        }).toList(),
        onChanged: (val) {
          if (val != null) {
            // Find the key for this value
            String? key;
            optionsMap.forEach((k, v) {
              if (v[lang] == val) key = k;
            });

            if (key != null) {
              setState(() {
                // Update all languages
                for (var l in ['en', 'tr', 'ar']) {
                  controllers[l]!.text = optionsMap[key]![l]!;
                }
              });
            }
          }
        },
        validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
      ),
    );
  }
}
