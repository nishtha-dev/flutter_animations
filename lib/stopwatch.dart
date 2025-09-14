// import 'package:flutter/material.dart';

// class StopwatchApp extends StatefulWidget {
//   const StopwatchApp({super.key});

//   @override
//   _StopwatchAppState createState() => _StopwatchAppState();
// }

// class _StopwatchAppState extends State<StopwatchApp>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   bool _isRunning = false;
//   Duration _elapsedTime = Duration.zero;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(hours: 1), // Arbitrary long duration
//     )..addListener(() {
//         setState(() {}); // Rebuild UI on animation updates
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _startStopwatch() {
//     if (_isRunning) {
//       _controller.stop();
//       _elapsedTime += _controller.lastElapsedDuration ?? Duration.zero;
//     } else {
//       _controller.forward(from: 0);
//     }
//     setState(() {
//       _isRunning = !_isRunning;
//     });
//   }

//   void _resetStopwatch() {
//     _controller.stop();
//     _controller.reset();
//     setState(() {
//       _isRunning = false;
//       _elapsedTime = Duration.zero;
//     });
//   }

//   String _formatTime(Duration duration) {
//     final totalMilliseconds = (_elapsedTime + duration).inMilliseconds;
//     final minutes = (totalMilliseconds ~/ 60000).toString().padLeft(2, '0');
//     final seconds =
//         ((totalMilliseconds ~/ 1000) % 60).toString().padLeft(2, '0');
//     final milliseconds =
//         ((totalMilliseconds ~/ 10) % 100).toString().padLeft(2, '0');
//     return "$minutes:$seconds:$milliseconds";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Stopwatch")),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Text(
//               _formatTime(_controller.lastElapsedDuration ?? Duration.zero),
//               style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: _startStopwatch,
//                 child: Text(_isRunning ? "Pause" : "Start"),
//               ),
//               const SizedBox(width: 10),
//               ElevatedButton(
//                 onPressed: _resetStopwatch,
//                 child: const Text("Reset"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

// class StopWatch extends StatefulWidget {
//   const StopWatch({super.key});

//   @override
//   State<StopWatch> createState() => _StopWatchState();
// }

// class _StopWatchState extends State<StopWatch>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   bool _isRunning = false;
//   Duration _elapsedTime = Duration.zero;

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         AnimationController(vsync: this, duration: const Duration(hours: 1))
//           ..addListener(() {
//             setState(() {}); // Rebuild UI on animation updates
//           });
//   }

//   void startStopwatch() {
//     if (_isRunning) {

//       _controller.stop();
//       _elapsedTime = _controller.lastElapsedDuration ?? Duration.zero;
//     } else {
//       _controller.forward(from: _elapsedTime.inSeconds.toDouble());
//     }

//     setState(() {
//       _isRunning = !_isRunning;
//     });
//   }

//   void _resetTimer() {
//     _controller.stop();
//     _controller.reset();

//     setState(() {
//       _isRunning = false;
//       _elapsedTime = Duration.zero;
//     });
//   }

//   String _durationText(Duration duration) {
//     int totalMilliseconds = (_elapsedTime + duration).inMilliseconds;
//     String minutes = (totalMilliseconds ~/ 6000).toString().padLeft(2, "0");
//     String seconds =
//         ((totalMilliseconds ~/ 1000) % 60).toString().padLeft(2, "0");
//     String millisecond =
//         ((totalMilliseconds ~/ 10) % 100).toString().padLeft(2, "0");
//     return "$minutes:$seconds:$millisecond";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Stopwatch")),
//       body: Column(
//         children: [
//           Text(
//             _durationText(_controller.lastElapsedDuration ?? Duration.zero),
//             style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     startStopwatch();
//                   },
//                   child: Text(_isRunning ? "Pause" : "Start")),
//               const SizedBox(
//                 width: 15,
//               ),
//               ElevatedButton(onPressed: _resetTimer, child: const Text("Reset"))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class StopwatchApp extends StatefulWidget {
  const StopwatchApp({super.key});

  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isRunning = false;
  Duration _elapsedTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(hours: 1), // Arbitrary long duration
    )..addListener(() {
        setState(() {}); // Rebuild UI on animation updates
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startStopwatch() {
    if (_isRunning) {
      _elapsedTime += _controller.lastElapsedDuration ?? Duration.zero;
      _controller.stop();
    } else {
      _controller.forward(from: _elapsedTime.inSeconds.toDouble());
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _resetStopwatch() {
    _controller.stop();
    _controller.reset();
    setState(() {
      _isRunning = false;
      _elapsedTime = Duration.zero;
    });
  }

  String _formatTime(Duration duration) {
    final totalMilliseconds = (_elapsedTime + duration).inMilliseconds;
    final minutes = (totalMilliseconds ~/ 60000).toString().padLeft(2, '0');
    final seconds =
        ((totalMilliseconds ~/ 1000) % 60).toString().padLeft(2, '0');
    final milliseconds =
        ((totalMilliseconds ~/ 10) % 100).toString().padLeft(2, '0');
    return "$minutes:$seconds:$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stopwatch")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              _formatTime(_controller.lastElapsedDuration ?? Duration.zero),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _startStopwatch,
                child: Text(_isRunning ? "Pause" : "Start"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _resetStopwatch,
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
