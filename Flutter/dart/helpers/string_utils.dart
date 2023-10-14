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

// ------

/// trim & remove the extra space from string
String normalizeString(String s) {
  var ns = s.trim();
  var pat = r'\s+';

  var re = RegExp(pat);
  // var mt = re.allMatches(ns).toList();
  // print(mt.map((e) => e[0]).toList());
  return ns.splitMapJoin(
    re,
    onMatch: (m) => ' ',
    onNonMatch: (nm) => nm,
  );

  // onMatch: (str) {
  //   print('Match ${str[0]}');
  //   return ' ';
  // },
  // onNonMatch: (str) {
  //   print('NonMatch $str');
  //   return str;
  // },
}

[EDGE CASE MAY FAIL]
/// split the [text] based on the priority queue [patterns] & apply corresponding method
///
/// param [text]: text that needs to be splitted into
///
/// param [patterns]: patterns that needs to be considered while splitting
///
/// param [onMatch]: (matchedText, matchedPattern) -> void
/// :: when any sub-text match is found by either of [patterns]
///
/// param [onNonMatch]: when any sub-text is not found by either of [patterns]
void splitApply(
  String? text,
  List<String?> patterns, {
  required void Function(Match matchedText, String matchedPattern) onMatch,
  required void Function(String? text) onNotMatch,
}) {
  if (text?.isEmpty ?? true) {
    return;
  }
  if (patterns.isEmpty) {
    onNotMatch(text);
    return;
  }
  final regexes = [for (final p in patterns) RegExp(p!)];
  final combinedRegex = RegExp(patterns.join('|'));

  text!.splitMapJoin(
    combinedRegex,
    onMatch: (m) {
      final matchedText = m[0];
      // TODO : Optimize this logic of identifying the regex from Match (instead of bruteforcing)
      // find the regex for this match
      final matchedRegex =
          regexes.firstWhere((r) => r.hasMatch(matchedText!));
      onMatch(m, matchedRegex.pattern);
      return '';
    },
    onNonMatch: (t) {
      onNotMatch(t);
      return '';
    },
  );
}

void splitApply(
  String text,
  List<RegExp> patterns, {
  required void Function(Match match, RegExp regex) onMatch,
  required void Function(String text) onNotMatch,
}) {
  if (text.isEmpty) return;
  if (patterns.isEmpty) {
    onNotMatch(text);
    return;
  }

  var curTxt = text;
  while (curTxt.isNotEmpty) {
    Match? match;
    RegExp? matchedRegex;
    // try to match each regex from [patterns]
    for (var regex in patterns) {
      final m = regex.firstMatch(curTxt);
      if (m != null) {
        // match found
        match = m;
        matchedRegex = regex;
        break;
      }
    }
    if (match != null) {
      //print('-> Found : ${match.group(0)} - ${match.start}:${match.end}');
      // Match found from one of the patterns
      var l = match.start;
      if (l > 0) {
        // Process pre-text (ie NonMatched) before matched text
        var priorTxt = curTxt.substring(0, l);
        onNotMatch(priorTxt);
      }
      // Process matched text
      //var macthedTxt = match.group(0)!;
      onMatch(match, matchedRegex!);

      curTxt = curTxt.substring(match.end); // update cur text
    } else {
      // match not found
      // add remaining text as non matched
      onNotMatch(curTxt);
      break;
    }
  }
}

/// split the [text] based on the priority queue [patterns]
List<T> splitMap<T>(
  String text,
  List<RegExp> patterns, {
  required T Function(Match match, RegExp regex) onMatch,
  required T Function(String text) onNotMatch,
}) {
  if (text.isEmpty) return [];
  if (patterns.isEmpty) return [onNotMatch(text)];

  final res = <T>[]; // holds the chunks of [text]

  var curTxt = text;
  while (curTxt.isNotEmpty) {
    Match? match;
    RegExp? matchedRegex;
    // try to match each regex from [patterns]
    for (var regex in patterns) {
      final m = regex.firstMatch(curTxt);
      if (m != null) {
        // match found
        match = m;
        matchedRegex = regex;
        break;
      }
    }
    if (match != null) {
      //print('-> Found : ${match.group(0)} - ${match.start}:${match.end}');
      // Match found from one of the patterns
      var l = match.start;
      if (l > 0) {
        // Process pre-text (ie NonMatched) before matched text
        var priorTxt = curTxt.substring(0, l);
        res.add(onNotMatch(priorTxt));
      }
      // Process matched text
      //var macthedTxt = match.group(0)!;
      res.add(onMatch(match, matchedRegex!));

      curTxt = curTxt.substring(match.end); // update cur text
    } else {
      // match not found
      // add remaining text as non matched
      res.add(onNotMatch(curTxt));
      break;
    }
  }
  return res;
}

