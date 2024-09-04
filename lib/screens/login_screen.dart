import 'package:copiando_package_codigo/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';

// import 'package:glowy_borders/glowy_borders.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return bakcxd();
    // return Scaffold(
    //   appBar: AppBar(
    //     // backgroundColor: Colors.indigoAccent,
    //     // leading: const Icon(Icons.menu),`
    //     centerTitle: true,
    //     title: const Text('Inicio de sesión'),
    //     forceMaterialTransparency: false,
    //     // actions: const [
    //     //   Icon(Icons.message_outlined),
    //     //   SizedBox(
    //     //     width: 20,
    //     //   )
    //     // ],
    //   ),
    //   body: Center(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(top: 20, bottom: 30),
    //           child: SizedBox(height: 250, child: Image.asset('assets/1.webp')),
    //         ),
    //         const Text(
    //           'BYTEGENIUS',
    //           style: TextStyle(fontWeight: FontWeight.w800, fontSize: 40),
    //         ),
    //         const Padding(
    //           padding: EdgeInsets.only(top: 20, bottom: 30),
    //           child: SizedBox(
    //             width: 350,
    //             child: Divider(),
    //           ),
    //         ),
    //         const SizedBox(
    //           width: 350,
    //           child: TextField(
    //             decoration: InputDecoration(
    //               suffixIcon: Icon(Icons.cancel_outlined),
    //               labelText: 'Correo',
    //               helperText: 'Ingrese su correo',
    //               filled: true,
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 40,
    //         ),
    //         const SizedBox(
    //           width: 350,
    //           child: TextField(
    //             decoration: InputDecoration(
    //               suffixIcon: Icon(Icons.cancel_outlined),
    //               labelText: 'Contraseña',
    //               helperText: 'Ingrese su contraseña',
    //               filled: true,
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 30,
    //         ),
    //         SizedBox(
    //           width: 350,
    //           height: 50,
    //           child: FilledButton(
    //             onPressed: () {
    //               Navigator.pushReplacementNamed(
    //                 context,
    //                 '/home',
    //               );
    //             },
    //             child: const Text("Ingresar"),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget bakcxd() {
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
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 310,
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.cancel_outlined),
                      labelText: 'Correo',
                      helperText: 'Ingrese su correo',
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(20))
                      // // filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 310,
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.cancel_outlined),
                      labelText: 'Contraseña',
                      helperText: 'Ingrese su contraseña',
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(20))
                      // // filled: true,
                    ),
                  ),
                ),
                // const SizedBox(height: 50),
                AnimatedGradientBorder(
                  borderRadius: BorderRadius.circular(999),
                  stretchAlongAxis: false,
                  glowSize: 15,
                  gradientColors: const [
                    Color.fromARGB(255, 65, 46, 130),
                    Color.fromARGB(255, 56, 21, 164),
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
                          // isGlowAtive = !isGlowAtive;
                          Navigator.pushNamed(context, '/code');
                        });
                        // Navigator.pushNamed(context, '/login');
                      },
                      child: const Text('Iniciar sesion',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
