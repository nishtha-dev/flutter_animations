import 'package:flutter/material.dart';

class AndroidStudio extends StatelessWidget {
  const AndroidStudio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.yellow,
              child: ClipPath(
                clipper: Clipper(),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                  ),
                ),
              ),
            ),
            // const Circle()
          ],
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  Clipper();

  @override
  Path getClip(Size size) {
    double radius = 20;
    const double width = 60;
    const double height = 60;
    Path path = Path();

    path.moveTo(0, 50);
    path.arcToPoint(Offset(width, radius),
        radius: Radius.circular(radius), clockwise: true);
    // path.quadraticBezierTo(width / 2, -radius, width, radius);
    path.lineTo(width, height);
    path.lineTo(0, height);

    // path.lineTo(width, 0);
    // path.lineTo(width, height - radius);
    // path.lineTo(0, height);

    // path.quadraticBezierTo(width / 2, height / 2, 0, height - radius);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Circle extends StatelessWidget {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            color: Colors.black,
            value: 1,
            strokeWidth: 30,
          ),
        ),
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            value: 1,
            strokeWidth: 30,
          ),
        )
      ],
    );
  }
}
