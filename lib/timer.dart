import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int seconds;

  const CountdownTimer({super.key, required this.seconds});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.seconds),
    )..forward(); // Start countdown

    _animation = Tween<double>(begin: widget.seconds.toDouble(), end: 0)
        .animate(_controller);
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
          animation: _animation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Circular progress
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value:
                        1 - _controller.value, // Inverse for countdown effect
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                // Countdown text
                Text(
                  _animation.value.ceil().toString(),
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
