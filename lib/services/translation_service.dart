import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  /// Simple unofficial Google Translate API wrapper
  static Future<String> translate(String text, String targetLang) async {
    if (text.trim().isEmpty) return "";

    try {
      // Using an unofficial endpoint for demonstration/utility
      // Note: This is for development convenience. Production apps should use Google Cloud Translation API.
      final url = Uri.parse(
        'https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$targetLang&dt=t&q=${Uri.encodeComponent(text)}',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data[0][0][0].toString();
      } else {
        return text; // Fallback to original
      }
    } catch (e) {
      print("Translation error: $e");
      return text;
    }
  }

  static Future<Map<String, String>> batchTranslate(
    String text,
    List<String> targetLangs,
  ) async {
    Map<String, String> results = {};
    for (String lang in targetLangs) {
      results[lang] = await translate(text, lang);
    }
    return results;
  }
}
