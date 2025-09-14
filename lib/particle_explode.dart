import 'dart:math';

import 'package:flutter/material.dart';

class ParticleExplosion extends StatefulWidget {
  const ParticleExplosion({super.key});

  @override
  _ParticleExplosionState createState() => _ParticleExplosionState();
}

class _ParticleExplosionState extends State<ParticleExplosion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {}); // Rebuild UI for animation
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _explode() {
    particles.clear();
    for (int i = 0; i < 100; i++) {
      double angle = _random.nextDouble() * 2 * pi;
      double speed = _random.nextDouble() * 4 + 2; // Speed range 2-6
      particles.add(
        Particle(
          x: 0,
          y: 0,
          dx: cos(angle) * speed,
          dy: sin(angle) * speed,
          radius: _random.nextDouble() * 4 + 2, // Size range 2-6
          color: Colors.primaries[_random.nextInt(Colors.primaries.length)],
        ),
      );
    }
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: ParticlePainter(particles, _controller.value),
          ),
          Positioned(
            bottom: 100,
            child: ElevatedButton(
              onPressed: _explode,
              child: const Text("Explode!"),
            ),
          ),
        ],
      ),
    );
  }
}

class Particle {
  double x, y, dx, dy, radius;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
    required this.radius,
    required this.color,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlePainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    for (var particle in particles) {
      paint.color = particle.color;
      double px = size.width / 2 + particle.dx * progress * 30; // Spread effect
      double py = size.height / 2 + particle.dy * progress * 30;
      canvas.drawCircle(Offset(px, py), particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

void main() {
  runApp(const MaterialApp(home: ParticleExplosion()));
}
