class SearchUtils {
  SearchUtils._();

  /// Normalizes Arabic and English text for robust searching:
  /// - Converts to lowercase.
  /// - Strips Arabic diacritics (Harakat / Tashkeel).
  /// - Normalizes Alef variations (أ, إ, آ, ٱ -> ا).
  /// - Normalizes Teh Marbuta to Heh (ة -> ه).
  /// - Normalizes Alef Maksura to Yeh (ى -> ي).
  static String normalize(String text) {
    if (text.isEmpty) return '';

    return text
        .toLowerCase()
        // Remove Arabic diacritics (Fatha, Damma, Kasra, Sukun, Tanween, Shadda, etc.)
        .replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '')
        // Normalize Alef variants
        .replaceAll(RegExp(r'[أإآٱ]'), 'ا')
        // Normalize Teh Marbuta
        .replaceAll('ة', 'ه')
        // Normalize Alef Maksura
        .replaceAll('ى', 'ي')
        .trim();
  }

  /// Checks if [source] contains [query] using normalized matching.
  static bool matches(String? source, String? query) {
    if (query == null || query.trim().isEmpty) return true;
    if (source == null || source.trim().isEmpty) return false;

    return normalize(source).contains(normalize(query));
  }
}
