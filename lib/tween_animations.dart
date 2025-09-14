import 'dart:math';

import 'package:flutter/material.dart';

class TweenTypeAnimations extends StatefulWidget {
  const TweenTypeAnimations({super.key});

  @override
  State<TweenTypeAnimations> createState() => _TweenTypeAnimationsState();
}

class _TweenTypeAnimationsState extends State<TweenTypeAnimations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder(
              tween: Tween(begin: 0, end: 2 * pi),
              duration: const Duration(seconds: 2),
              builder: (context, angle, child) {
                return Transform.rotate(
                  angle: angle.toDouble(),
                  child: const Text("data here"),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TweenAnimationBuilder(
                tween: ColorTween(begin: Colors.black, end: Colors.pink),
                duration: const Duration(seconds: 2),
                builder: (context, color, child) {
                  return Text(
                    "nishtha",
                    style: TextStyle(color: color),
                  );
                }),
          )
        ],
      ),
    );
  }
}
