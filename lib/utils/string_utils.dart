import 'dart:convert';
import 'package:crypto/crypto.dart';

class StringUtils {
  static String normalizePhoneInternational(String raw) {
    if (raw.trim().isEmpty) return '';
    String cleaned = raw.trim();
    if (cleaned.startsWith('00')) {
      cleaned = cleaned.substring(2);
    }
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }
    cleaned = cleaned.replaceAll(RegExp(r'[^0-9+]'), '');
    cleaned = cleaned.replaceFirst(RegExp(r'^\++'), '+');
    return cleaned;
  }

  static String contactFingerprint(String value) {
    final bytes = utf8.encode(value.trim().toLowerCase());
    return sha256.convert(bytes).toString();
  }
}
