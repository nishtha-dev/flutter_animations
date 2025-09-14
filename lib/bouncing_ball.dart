// import 'package:flutter/material.dart';

// class BouncingBall extends StatefulWidget {
//   const BouncingBall({super.key});

//   @override
//   _BouncingBallState createState() => _BouncingBallState();
// }

// class _BouncingBallState extends State<BouncingBall>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);

//     _animation =
//         CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _animation,
//           builder: (context, child) {
//             return Transform.translate(
//               offset: Offset(0, -100 * _animation.value), // Move up and down
//               child: child,
//             );
//           },
//           child: Container(
//             width: 50,
//             height: 50,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.blue,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        child: Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          ),
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -100 * _animation.value),
            child: child,
          );
        },
      ),
    );
  }
}
