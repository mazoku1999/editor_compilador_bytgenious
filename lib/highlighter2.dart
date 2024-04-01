// import 'dart:convert';

// import 'package:copiando_package_codigo/span_parser.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'textspan_controller.dart';

// const _bracketStyles = <TextStyle>[
//   TextStyle(color: Color(0xFF5caeef)),
//   TextStyle(color: Color(0xFFdfb976)),
//   TextStyle(color: Color(0xFFc172d9)),
//   TextStyle(color: Color(0xFF4fb1bc)),
//   TextStyle(color: Color(0xFF97c26c)),
//   TextStyle(color: Color(0xFFabb2c0)),
// ];

// const _failedBracketStyle = TextStyle(color: Color(0xFFff0000));

// const _defaultLightThemeFiles = [
//   'lib/themes/light_vs.json',
//   'lib/themes/light_plus.json',
// ];

// const _defaultDarkThemeFiles = [
//   'lib/themes/dark_vs.json',
//   'lib/themes/dark_plus.json',
// ];

// typedef ValueChangedCallback = void Function(String);

// class Highlighter2 {
//   static final _cache = <String, Grammar>{};

//   Highlighter2({
//     required this.language,
//     required this.theme,
//     required this.onChanged,
//   }) {
//     _grammar = _cache[language]!;
//     onChanged = onChanged;
//   }

//   static Future<void> initialize(List<String> languages) async {
//     for (var language in languages) {
//       var json = await rootBundle.loadString(
//         'lib/grammars/$language.json',
//       );
//       _cache[language] = Grammar.fromJson(jsonDecode(json));
//     }
//   }

//   final String language;
//   late final Grammar _grammar;
//   final Highlighter2Theme theme;
//   ValueChangedCallback onChanged;

//   TextSpan highlight(String code) {
//     var spans = SpanParser.parse(_grammar, code);
//     var textSpans = <TextSpan>[];
//     var bracketCounter = 0;
//     var lines = code.split('\n');
//     // print('lines: ${lines.length}');
//     // for (var line in lines) {
//     //   if (line.trim().isEmpty) {
//     //     print('Lineascon texto: $line');
//     //   }
//     // }
//     int charPos = 0;
//     int cont = 0;
//     for (var span in spans) {
//       if (span.start > charPos) {
//         var text = code.substring(charPos, span.start);
//         // print('text: $text');
//         TextSpan? textSpan;
//         (textSpan, bracketCounter) = _formatBrackets(text, bracketCounter);
//         textSpans.add(
//           textSpan,
//         );

//         charPos = span.start;
//       }
//       cont++;
//       var segment = code.substring(span.start, span.end);
//       var style = theme._getStyle(span.scopes);
//       textSpans.add(
//         TextSpan(
//           text: segment,
//           style: style,
//         ),
//       );

//       charPos = span.end;
//     }

//     if (charPos < code.length) {
//       var text = code.substring(charPos, code.length);
//       TextSpan? textSpan;
//       (textSpan, bracketCounter) = _formatBrackets(text, bracketCounter);
//       textSpans.add(
//         textSpan,
//       );
//     }
//     // for (var span in textSpans) {
//     //   print('span: ${span.toPlainText()}');
//     // }
//     // print('tamanio spands: ${textSpans.length}');
//     // //unir todos los textspans en un solo texto
//     // var text3 = '';
//     // for (var span in textSpans) {
//     //   text3 += span.toPlainText();
//     // }
//     // print('text3: $text3');
//     return TextSpan(
//       children: textSpans,
//       style: GoogleFonts.jetBrainsMono(
//         fontSize: 14,
//         height: 1.3,
//       ),
//     );
//   }

//   (TextSpan, int) _formatBrackets(String text, int bracketCounter) {
//     var spans = <TextSpan>[];
//     var plainText = '';
//     for (var char in text.characters) {
//       if (_isStartingBracket(char)) {
//         if (plainText.isNotEmpty) {
//           spans.add(TextSpan(text: plainText));
//           plainText = '';
//         }

//         spans.add(TextSpan(
//           text: char,
//           style: _getBracketStyle(bracketCounter),
//         ));
//         bracketCounter += 1;
//         plainText = '';
//       } else if (_isEndingBracket(char)) {
//         if (plainText.isNotEmpty) {
//           spans.add(TextSpan(text: plainText));
//           plainText = '';
//         }

//         bracketCounter -= 1;
//         spans.add(TextSpan(
//           text: char,
//           style: _getBracketStyle(bracketCounter),
//         ));
//         plainText = '';
//       } else {
//         plainText += char;
//       }
//     }
//     if (plainText.isNotEmpty) {
//       spans.add(TextSpan(text: plainText));
//     }

//     if (spans.length == 1) {
//       return (spans[0], bracketCounter);
//     } else {
//       return (TextSpan(children: spans), bracketCounter);
//     }
//   }

//   TextStyle _getBracketStyle(int bracketCounter) {
//     if (bracketCounter < 0) {
//       return _failedBracketStyle;
//     }
//     return _bracketStyles[bracketCounter % _bracketStyles.length];
//   }

//   bool _isStartingBracket(String bracket) {
//     return bracket == '{' || bracket == '[' || bracket == '(';
//   }

//   bool _isEndingBracket(String bracket) {
//     return bracket == '}' || bracket == ']' || bracket == ')';
//   }
// }

// class Highlighter2Theme {
//   final TextStyle _wrapper;
//   TextStyle? _fallback;
//   final _scopes = <String, TextStyle>{};

//   Highlighter2Theme._({required TextStyle wrapper}) : _wrapper = wrapper;

//   factory Highlighter2Theme.fromConfiguration(
//     String json,
//     TextStyle defaultStyle,
//   ) {
//     final theme = Highlighter2Theme._(wrapper: defaultStyle);
//     theme._parseTheme(json);
//     return theme;
//   }

//   static Future<Highlighter2Theme> loadForBrightness(
//     Brightness brightness,
//   ) async {
//     if (brightness == Brightness.dark) {
//       return loadDarkTheme();
//     } else {
//       return loadLightTheme();
//     }
//   }

//   static Future<Highlighter2Theme> loadForContext(
//     BuildContext context,
//   ) async {
//     return loadForBrightness(
//       Theme.of(context).brightness,
//     );
//   }

//   static Future<Highlighter2Theme> loadDarkTheme() async {
//     return loadFromAssets(
//       _defaultDarkThemeFiles,
//       const TextStyle(color: Color(0xFFB9EEFF)),
//     );
//   }

//   static Future<Highlighter2Theme> loadLightTheme() async {
//     return loadFromAssets(
//       _defaultLightThemeFiles,
//       const TextStyle(color: Color(0xFF000088)),
//     );
//   }

//   static Future<Highlighter2Theme> loadFromAssets(
//     List<String> jsonFiles,
//     TextStyle defaultStyle,
//   ) async {
//     var theme = Highlighter2Theme._(wrapper: defaultStyle);
//     await theme._load(jsonFiles);
//     return theme;
//   }

//   Future<void> _load(List<String> definitions) async {
//     for (var definition in definitions) {
//       var json = await rootBundle.loadString(
//         definition,
//       );
//       _parseTheme(json);
//     }
//   }

//   void _parseTheme(String json) {
//     var theme = jsonDecode(json);
//     List settings = theme['settings'];
//     for (Map setting in settings) {
//       var style = _parseTextStyle(setting['settings']);

//       var scopes = setting['scope'];
//       if (scopes is String) {
//         _addScope(scopes, style);
//       } else if (scopes is List) {
//         for (String scope in scopes) {
//           _addScope(scope, style);
//         }
//       } else if (scopes == null) {
//         _fallback = style;
//       }
//     }
//   }

//   TextStyle _parseTextStyle(Map setting) {
//     Color? color;
//     var foregroundSetting = setting['foreground'];
//     if (foregroundSetting is String && foregroundSetting.startsWith('#')) {
//       color = Color(
//         int.parse(
//               foregroundSetting.substring(1),
//               radix: 16,
//             ) |
//             0xFF000000,
//       );
//     }

//     FontStyle? fontStyle;
//     FontWeight? fontWeight;
//     TextDecoration? textDecoration;

//     var fontStyleSetting = setting['fontStyle'];
//     if (fontStyleSetting is String) {
//       if (fontStyleSetting == 'italic') {
//         fontStyle = FontStyle.italic;
//       } else if (fontStyleSetting == 'bold') {
//         fontWeight = FontWeight.bold;
//       } else if (fontStyleSetting == 'underline') {
//         textDecoration = TextDecoration.underline;
//       } else {
//         throw Exception('WARNING unknown style: $fontStyleSetting');
//       }
//     }

//     return TextStyle(
//       color: color,
//       fontStyle: fontStyle,
//       fontWeight: fontWeight,
//       decoration: textDecoration,
//     );
//   }

//   void _addScope(String scope, TextStyle style) {
//     _scopes[scope] = style;
//   }

//   TextStyle? _getStyle(List<String> scope) {
//     for (var s in scope) {
//       var fallbacks = _fallbacks(s);
//       for (var f in fallbacks) {
//         var style = _scopes[f];
//         if (style != null) {
//           return style;
//         }
//       }
//     }
//     return _fallback;
//   }

//   List<String> _fallbacks(String scope) {
//     var fallbacks = <String>[];
//     var parts = scope.split('.');
//     for (var i = 0; i < parts.length; i++) {
//       var s = parts.sublist(0, i + 1).join('.');
//       fallbacks.add(s);
//     }
//     return fallbacks.reversed.toList();
//   }
// }
