import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedClock extends StatefulWidget {
  const AnimatedClock({super.key});

  @override
  _AnimatedClockState createState() => _AnimatedClockState();
}

class _AnimatedClockState extends State<AnimatedClock>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 60), // Completes a full revolution in 60s
    )..repeat(); // Loops forever
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(300, 300),
              painter: ClockPainter(_controller.value),
            );
          },
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final double animationValue;

  ClockPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final Paint circlePaint = Paint()..color = Colors.black;
    final Paint centerDotPaint = Paint()..color = Colors.red;

    canvas.drawCircle(center, radius, circlePaint); // Draw clock face
    canvas.drawCircle(center, 5, centerDotPaint); // Center dot

    final DateTime now = DateTime.now();

    // Smooth seconds based on animationValue
    final double smoothSeconds =
        now.second + now.millisecond / 1000.0 + animationValue;
    final double secondAngle = (pi / 30) * smoothSeconds;

    final Paint secondHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final handLength = radius * 0.8;
    final secondHandOffset = center +
        Offset(handLength * sin(secondAngle), -handLength * cos(secondAngle));

    // Draw second hand
    canvas.drawLine(center, secondHandOffset, secondHandPaint);
  }

  @override
  bool shouldRepaint(covariant ClockPainter oldDelegate) {
    return true; // Continuously repaint for smooth motion
  }
}

class DynamicBackgroundClock extends StatefulWidget {
  const DynamicBackgroundClock({super.key});

  @override
  _DynamicBackgroundClockState createState() => _DynamicBackgroundClockState();
}

class _DynamicBackgroundClockState extends State<DynamicBackgroundClock> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();
  Color _currentColor = Colors.lightBlueAccent; // Default color

  @override
  void initState() {
    super.initState();
    _updateBackgroundColor(); // Set initial background color

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
        _updateBackgroundColor();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateBackgroundColor() {
    int hour = _currentTime.hour;
    if (hour >= 6 && hour < 12) {
      _currentColor = Colors.lightBlueAccent; // Morning
    } else if (hour >= 12 && hour < 18) {
      _currentColor = Colors.orangeAccent; // Afternoon
    } else {
      _currentColor = Colors.indigo; // Night
    }
  }

  String _formatDigitalTime() {
    return "${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TweenAnimationBuilder<Color?>(
        tween: ColorTween(begin: _currentColor, end: _currentColor),
        duration: const Duration(seconds: 1),
        builder: (context, color, child) {
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            color: color,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPaint(
                    size: const Size(300, 300),
                    painter: ClockPainter2(_currentTime),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _formatDigitalTime(),
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ClockPainter2 extends CustomPainter {
  final DateTime time;
  ClockPainter2(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final Paint circlePaint = Paint()..color = Colors.white;
    final Paint centerDotPaint = Paint()..color = Colors.black;

    canvas.drawCircle(center, radius, circlePaint);
    canvas.drawCircle(center, 5, centerDotPaint);

    // Get angles for hands
    double secondAngle = (pi / 30) * time.second;
    double minuteAngle = (pi / 30) * time.minute;
    double hourAngle = (pi / 6) * (time.hour % 12) + (pi / 360) * time.minute;

    _drawHand(canvas, center, secondAngle, radius * 0.8, Colors.red, 2);
    _drawHand(canvas, center, minuteAngle, radius * 0.7, Colors.black, 4);
    _drawHand(canvas, center, hourAngle, radius * 0.5, Colors.black, 6);
  }

  void _drawHand(Canvas canvas, Offset center, double angle, double length,
      Color color, double width) {
    final Paint handPaint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;

    final Offset handEnd =
        center + Offset(length * sin(angle), -length * cos(angle));
    canvas.drawLine(center, handEnd, handPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(const MaterialApp(home: DynamicBackgroundClock()));
}
