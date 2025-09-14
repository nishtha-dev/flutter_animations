import 'package:flutter/material.dart';
import 'package:flutter_animations/popper_animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const PopperAnimation();
  }
}

class FlutterFlakesWidget extends StatelessWidget {
  const FlutterFlakesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Transform.rotate(
                  angle: 3.14,
                  child: const FlutterLogo(
                    angel: -3.14 / 4,
                    color: Color(0xFF0C6B91),
                  ),
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              const FlutterLogo(
                angel: -3.14 / 4,
                color: Color(0xFF0C6B91),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 0),
                child: Transform.rotate(
                  angle: -3.14 / 2,
                  child: const FlutterLogo(
                    angel: -3.14 / 4,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.only(right: 10, bottom: 20),
                child: Transform.rotate(
                  angle: 3.14 / 2,
                  child: const FlutterLogo(
                    angel: -3.14 / 4,
                    color: Color(0xFF0C6B91),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class FlutterLogo extends StatelessWidget {
  const FlutterLogo({
    super.key,
    required this.angel,
    required this.color,
  });
  final double angel;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angel,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: _CustomClipper(offset1: 40),
            child: Container(
              decoration: BoxDecoration(
                  // color: Color(0xFF5FC5F4),
                  color: color),
              width: 150,
              height: 40,
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              ClipPath(
                clipper: _CustomClipper(offset1: 40),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      // color: Color(0xFF5FC5F4),
                      color: color),
                  child: const SizedBox(
                    width: 110,
                    height: 40,
                  ),
                ),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: ClipPath(
                  clipper: _CustomClipper(offset1: 0, offset2: 40),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        // color: Color(0xFF045A98),
                        color: color),
                    child: const SizedBox(
                      width: 110,
                      height: 40,
                    ),
                  ),
                ),
              ),
              // const DecoratedBox(
              //   decoration: BoxDecoration(
              //     color: Color(0xFF31B4F2),
              //   ),
              //   child: SizedBox(
              //     width: 40,
              //     height: 40,
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  _CustomClipper({
    required this.offset1,
    this.offset2 = 0,
  });
  final double offset1;
  final double offset2;
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    final path = Path();

    if (offset2 != 0) {
      path.lineTo(width, 0);
      path.lineTo(width - offset2, height);
    } else {
      path.lineTo(width - offset1, 0);
      path.lineTo(width, height);
    }
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
