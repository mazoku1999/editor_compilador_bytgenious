import 'package:copiando_package_codigo/highlighter.dart';
import 'package:copiando_package_codigo/screens/login_screen.dart';
import 'package:copiando_package_codigo/screens/sigin_screen.dart';
import 'package:copiando_package_codigo/screens/welcome_screen.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:debug_console/debug_console.dart';
import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:google_fonts/google_fonts.dart';

import 'textspan_controller.dart';

late final Highlighter _dartDarkHighlighter;
late final Highlighter _sqlDarkHighlighter;

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
  var darkTheme2 = await HighlighterTheme.loadDarkTheme();
  _sqlDarkHighlighter = Highlighter(
    language: 'sql',
    theme: darkTheme2,
  );

  runApp(const MyApp());
  // DebugConsole.listen(() {
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Syntax Highlight Demo',
      theme: ThemeData.dark(),
      initialRoute: '/code',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/sigin': (context) => const SiginScreen(),
        '/code': (context) => const MyHomePage(),
      },
    );
  }
}

class Prueba {
  const Prueba();
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final sql = '''
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  age INTEGER NOT NULL
);
''';
final _dartCode = '''
void main() async {
  
  for (var i = 0; i <= 10; i++) {
    await Future.delayed(Duration(milliseconds: 700));
    print('Josue: ' + i.toString());
    //print('Hola');
  }
  int a = 50;
  int b = 20;
  print(a + b);
}
''';
final _dartCode2 = '''
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

TextEditingController controller = TextEditingController();
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    List<String> palabras = ["Hola", "Juan", "tengo"];
    String texto = "Hola soy Juan y tengo 20";
    List<TextEditingController> controllers = [];

    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Reemplazar palabras'),
        ),
        body: Center(
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  children: _crearSpans(texto, palabras),
                ),
              ),
              Text(cargar(controll   TextField(
                controller: controller,
                autofocus: true,
                showCursor: true,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              FilledButton(
                onPressed: () {
                  controller.text = "Se agrego texto";
                  setState(() {
                    
                  });
                },
                child: Text("Cargar Texto"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String cargar(List<TextEditingController> controllers) {
    int count = 0;
    String text = '';
    for (var i = 0; i < 4; i++) {
      count++;
      TextEditingController controller =
          TextEditingController(text: count.toString());
      controllers.add(controller);
    }

    controllers.forEach((TextEditingController data) {
      text += data.text;
    });

    return text;
  }

  List<InlineSpan> _crearSpans(String texto, List<String> palabras) {
    List<InlineSpan> spans = [];

    List<String> palabrasEnTexto = texto.split(' ');
    List<TextEditingController> controllers = [];

    for (var palabra in palabrasEnTexto) {
      TextEditingController controller = TextEditingController(text: palabra);
      controllers.add(controller);
      if (palabras.contains(palabra)) {
        spans.add(
          WidgetSpan(
            child: IntrinsicWidth(
              child: TextField(
                controller: controller,
                style: TextStyle(color: Colors.blue),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // isDense: false,
                  // isCollapsed: true,
                ),
              ),
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: palabra,
          ),
        );
      }
      spans.add(TextSpan(text: ' '));
    }

    return spans;
  }
}
''';

late TextSpanTextFieldController controller;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    controller =
        TextSpanTextFieldController(dartDarkHighlighter: _dartDarkHighlighter);
    controller.text = _dartCode2;
    controllerCode.text = _dartCode;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void prueba() async {
    int messi = 10;
    for (var goku = 0; goku <= 10; goku++) {
      await Future.delayed(Duration(milliseconds: 700));
      print('Josue: ' + goku.toString());
    }
  }

  TextSpanTextFieldController controllerCode =
      TextSpanTextFieldController(dartDarkHighlighter: _dartDarkHighlighter);
  void prueba2() {
    // print(eval('2 + 2')); // -> 4

    final program = _dartCode;

    try {
      eval(controllerCode.text, function: 'main');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("build MyApp");
    // print(_dartDarkHighlighter.highlight(_dartCode).toPlainText());
    //remplazar la posicion 0 por otro textspand
    // print(_dartDarkHighlighter
    //     .highlight(_dartCode)
    //     .getSpanForPosition(TextPosition(offset: 3)));
    // _dartDarkHighlighter.highlight(_dartCode).children?.forEach((element) {
    //   // print('Texto plano: ${element.toPlainText()}');
    //   // print("Informacion: ${element.getSemanticsInformation()}");
    //   element.getSemanticsInformation().forEach((element) {
    //     print(element.text);
    //   });
    // });

    // print(
    // _dartDarkHighlighter.highlight(_dartCode).getSemanticsInformation()[0]);

    return DebugConsolePopup(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Editor y Compilador",
            style: TextStyle(
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontWeight: FontWeight.w600,
              wordSpacing: 0.1,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   padding: const EdgeInsets.all(5),
              //   color: Colors.black,
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Text.rich(
              //       _dartDarkHighlighter.obtenerPosiciones(_dartCode),
              //       style: GoogleFonts.jetBrainsMono(
              //         fontSize: 16,
              //         height: 1.3,
              //       ),
              //     ),
              //   ),
              // ),

              Container(
                height: 350,
                decoration: const BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.white,
                  // ),
                  color: Colors.black,
                ),
                padding: const EdgeInsets.all(5),
                child: TextField(
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 16,
                    height: 1.3,
                  ),
                  controller: controllerCode,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  maxLines: null,
                ),
              ),
              AnimatedGradientBorder(
                borderRadius: BorderRadius.circular(999),
                // stretchAlongAxis: true,
                glowSize: 15,
                borderSize: 3,
                gradientColors: const [
                  Color.fromARGB(255, 65, 46, 130),
                  Color.fromARGB(255, 56, 21, 164),
                  Color.fromARGB(255, 66, 22, 199),
                  Color.fromARGB(255, 65, 9, 233),
                  // Color.fromARGB(255, 64, 0, 255),
                ],
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(999)),
                  height: 57,
                  width: 200,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        DebugConsole.listen(() {
                          prueba2();
                        });
                      });
                    },
                    child: Text(
                      'Compilar',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        fontWeight: FontWeight.w900,
                        wordSpacing: 0.1,
                      ),
                    ),
                  ),
                ),
              ),

              // TextField(
              //   controller: TextEditingController(
              //       text: _dartDarkHighlighter
              //           .highlight(_dartCode)
              //           .children
              //           .toString()),
              //   decoration: const InputDecoration(
              //     border: InputBorder.none,
              //   ),
              //   maxLines: null,
              // ),
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
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   color: Colors.black,
              //   child: TextField(
              //     controller: controller,
              //     decoration: const InputDecoration(
              //       border: InputBorder.none,
              //     ),
              //     maxLines: null,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
