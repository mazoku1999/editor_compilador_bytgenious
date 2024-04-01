import 'package:copiando_package_codigo/highlighter.dart';
import 'package:flutter/material.dart';

class TextSpanTextFieldController extends TextEditingController {
  final Highlighter dartDarkHighlighter;
  // int cont = 0;

  // Modificar el constructor para evitar la llamada redundante al constructor de la clase padre
  TextSpanTextFieldController({
    required this.dartDarkHighlighter,
  });

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    // cont++;
    // print(cont);
    return dartDarkHighlighter.highlight(text);
  }
}
