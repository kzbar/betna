import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> uploadFile({
    required Uint8List bytes,
    required String fileName,
    String? folder,
  }) async {
    try {
      Reference ref = _storage.ref();
      if (folder != null) {
        ref = ref.child(folder);
      }
      ref = ref.child(fileName);

      UploadTask uploadTask = ref.putData(bytes);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      if (kDebugMode) print("Upload error: $e");
      return null;
    }
  }

  static Future<String?> uploadPropertyImage(
    XFile file, {
    String? fileName,
    String? folder,
  }) async {
    final bytes = await file.readAsBytes();
    String name =
        fileName ?? 'property_${DateTime.now().millisecondsSinceEpoch}.jpg';
    return await uploadFile(
      bytes: bytes,
      fileName: name,
      folder: folder ?? 'properties',
    );
  }

  static Future<XFile?> pickImage() async {
    return await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
  }

  static Future<List<XFile>> pickMultiImage() async {
    return await _picker.pickMultiImage(imageQuality: 80);
  }

  static Future<PlatformFile?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
    );

    if (result != null) {
      return result.files.first;
    }
    return null;
  }
}
