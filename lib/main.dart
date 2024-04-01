import 'package:copiando_package_codigo/highlighter.dart';
import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';

import 'textspan_controller.dart';

late final Highlighter _dartDarkHighlighter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the highlighter.
  await Highlighter.initialize([
    'dart',
    'yaml',
    'sql',
    'serverpod_protocol',
    'json',
  ]);

  // Load the default dark theme and create a highlighter.
  var darkTheme = await HighlighterTheme.loadDarkTheme();
  _dartDarkHighlighter = Highlighter(
    language: 'dart',
    theme: darkTheme,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syntax Highlight Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final _dartCode = '''
void main() async {
  for (var i = 0; i <= 10; i++) {
    await Future.delayed(Duration(milliseconds: 700));
    print('Josue: ' + i.toString());
  }
}
''';

late TextSpanTextFieldController controller;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    controller =
        TextSpanTextFieldController(dartDarkHighlighter: _dartDarkHighlighter);
    controller.text = _dartCode;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build MyApp");

    return Scaffold(
      body: ListView(
        children: [
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   color: Colors.black,
          //   child: Text.rich(
          //     _dartDarkHighlighter.highlight(_dartCode),
          //     style: GoogleFonts.firaCode(
          //       fontSize: 16,
          //       height: 1.3,
          //     ),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
