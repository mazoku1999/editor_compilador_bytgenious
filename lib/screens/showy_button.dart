import 'dart:ui';

import 'package:flutter/material.dart';

class ShowyButton extends StatefulWidget {
  final Widget? label;
  final VoidCallback? onPressed;

  const ShowyButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  State<ShowyButton> createState() => _ShowyButtonState();
}

class _ShowyButtonState extends State<ShowyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Tween<double> tween;
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    tween = Tween<double>(begin: 0, end: 359);
    animation = controller.drive(tween);
    controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Stack(
            clipBehavior: Clip.hardEdge,
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                // clipBehavior: Clip.hardEdge,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.076,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: _generateGradientColors(animation.value),
                    stops: _generateGradientStops(),
                  ),
                ),
                foregroundDecoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.1, 1],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: MediaQuery.of(context).size.width * 0.49,
                    height: MediaQuery.of(context).size.height * 0.0730,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: FilledButton(
                      onPressed: widget.onPressed,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.black,
                        disabledForegroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35),
                          ),
                        ),
                      ),
                      child: widget.label,
                    ),
                  ),
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 45.0,
                      sigmaY: 25.0,
                      tileMode: TileMode.decal,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.583,
                      height: 35, //oculta las sombras
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: _generateGradientColors(animation.value),
                          stops: _generateGradientStops(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // ImageFiltered(
              //   imageFilter: ImageFilter.blur(
              //     sigmaX: 25.0,
              //     sigmaY: 25.0,
              //     tileMode: TileMode.decal,
              //   ),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width * 0.783,
              //     height: 105,
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         begin: Alignment.centerLeft,
              //         end: Alignment.centerRight,
              //         colors: _generateGradientColors(animation.value),
              //         stops: _generateGradientStops(),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        });
  }

  List<Color> _generateGradientColors(double offset) {
    List<Color> colors = [];
    const int divisions = 10; // Number of color divisions
    for (int i = 0; i < divisions; i++) {
      double hue = (360 / divisions) * i;
      hue += offset;
      if (hue > 360) {
        hue -= 360;
      }
      final Color color = HSVColor.fromAHSV(1.0, hue, 0.7, 1).toColor();

      colors.add(color);
    }

    colors.add(colors[0]);
    return colors;
  }

  List<double> _generateGradientStops() {
    const int divisions = 10; // Number of color divisions
    List<double> stops = [];
    for (int i = 0; i <= divisions; i++) {
      stops.add(i / divisions);
    }
    return stops;
  }
}
