import 'dart:math';

import 'package:flutter/material.dart';

class PopperAnimation extends StatefulWidget {
  const PopperAnimation({super.key});

  @override
  _PopperAnimationState createState() => _PopperAnimationState();
}

class _PopperAnimationState extends State<PopperAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<ConfettiParticle> particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {}); // Repaint animation
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startPopper() {
    particles.clear();
    for (int i = 0; i < 50; i++) {
      double angle = _random.nextDouble() * 2 * pi; // Random direction
      double speed = _random.nextDouble() * 4 + 2; // Speed range 2-6
      particles.add(
        ConfettiParticle(
          dx: cos(angle) * speed,
          dy: sin(angle) * speed,
          size: _random.nextDouble() * 6 + 4, // Size 4-10
          color: Colors.primaries[_random.nextInt(Colors.primaries.length)],
        ),
      );
    }
    _controller.forward(from: 0); // Start animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: ConfettiPainter(particles, _controller.value),
          ),
          Positioned(
            bottom: 100,
            child: ElevatedButton(
              onPressed: _startPopper,
              child: const Text("Pop! 🎉"),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfettiParticle {
  double dx, dy, size;
  Color color;

  ConfettiParticle(
      {required this.dx,
      required this.dy,
      required this.size,
      required this.color});
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double progress;

  ConfettiPainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    for (var particle in particles) {
      paint.color = particle.color;
      double px = size.width / 2 + particle.dx * progress * 50; // Spread effect
      double py = size.height / 2 + particle.dy * progress * 50;
      canvas.drawCircle(Offset(px, py), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
