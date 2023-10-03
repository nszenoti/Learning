//string_utils.dart

extension StringExtensions on String? {
  /// Check if {s} is null or empty
  bool get isNullOrEmpty {
    return this == null ? true : this!.isEmpty;
  }
}

extension StringUtils on String {
  /// Check if {s} is comprised of only whitespaces or not
  bool get isBlank {
    return trim() == '';
  }

  /// get the first word from string, if string is not empty
  String get firstWord {
    if (isEmpty) {
      return '';
    }
    return split(RegExp(r'\s+')).first;
  }
}