import 'package:copiando_package_codigo/screens/showy_button.dart';
import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isGlowAtive = true;
  @override
  void initState() {
    // activar();
    // TODO: implement initState
    super.initState();
  }

  // activar() async {
  //   Future.delayed(Duration(seconds: 2)).then((value) {
  //     setState(() {
  //       isGlowAtive = true;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned(
            top: -550,
            left: -300,
            width: 1000,
            height: 1000,
            child: BackGround(),
          ),
          Positioned(
            top: isGlowAtive == true ? -20 : 70,
            right: isGlowAtive == true ? -70 : 20,
            child: Align(
              alignment: Alignment.topRight,
              child: AnimatedGradientBorder(
                  borderRadius: BorderRadius.circular(999),
                  stretchAlongAxis: false,
                  glowSize: isGlowAtive == true ? 30 : 0,
                  gradientColors: const [
                    Color(0xFFFF0000),
                    Color(0xFFFFFF00),
                    Color(0xFF00FF00),
                    Color(0xFF00FFFF),
                    Color(0xFF0000FF),
                    Color(0xFFFF00FF),
                  ],
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(999)),
                    height: 57,
                    width: 160,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          // isGlowAtive = !isGlowAtive;
                          Navigator.pushNamed(context, '/login');
                        });
                        // Navigator.pushNamed(context, '/login');
                      },
                      child: const Text('Iniciar sesion',
                          style: TextStyle(color: Colors.white)),
                    ),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Column(
                children: [
                  Image.asset(
                    'assets/1.webp',
                    height: 200,
                    width: 200,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ShowyButton(
                label: const Text(
                  'Registrate Ahora',
                  style: TextStyle(
                    color: Colors.white,
                    // fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/sigin');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackGround extends StatelessWidget {
  const BackGround({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          radius: 0.7,
          center: Alignment(0.1, 0.0),
          stops: [
            0.01,
            0.02,
            0.7,
            // 0.8,
            // 0.8,
            // 0.4,
            // 0.5,
            // 0.6,
          ],
          // radius: 0.5,
          colors: [
            Color.fromARGB(255, 117, 54, 227),
            Color.fromARGB(255, 47, 37, 95),
            Color.fromARGB(255, 0, 0, 0),
          ],
        ),
      ),
    );
  }
}
