import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 2,
    ),
  )..forward();

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  final _random = Random();

  late Animation<double> _progress = Tween(
    begin: 0.005,
    end: _random.nextDouble() * 2.0,
  ).animate(_curve);

  void _animateValues() {
    final newBegin = _progress.value;
    final random = Random();
    final newEnd = random.nextDouble() * 2.0;

    setState(
      () {
        _progress = Tween(
          begin: newBegin,
          end: newEnd,
        ).animate(_curve);
      },
    );
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("Apple Watch!"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _progress,
          builder: (context, child) {
            return CustomPaint(
              painter: AppleWatchPainter(
                progress: _progress.value,
              ),
              size: const Size(400, 400),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValues,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double progress;

  AppleWatchPainter({
    required this.progress,
  });

  static final redRandom = Random().nextDouble() * 2;
  static final greenRandom = Random().nextDouble() * 2;
  static final blueRandom = Random().nextDouble() * 2;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    const startingAngle = -0.5 * pi;
    // draw red
    final redCirclePaint = Paint()
      ..color = Colors.red.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final redCircleRadius = (size.width / 2) * 0.9;

    canvas.drawCircle(
      center,
      redCircleRadius,
      redCirclePaint,
    );
    // draw green
    final greenCirclePaint = Paint()
      ..color = Colors.green.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final greenCircleRadius = (size.width / 2) * 0.76;

    canvas.drawCircle(
      center,
      greenCircleRadius,
      greenCirclePaint,
    );
    // draw blue
    final blueCirclePaint = Paint()
      ..color = Colors.blue.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final blueCircleRadius = (size.width / 2) * 0.62;

    canvas.drawCircle(
      center,
      blueCircleRadius,
      blueCirclePaint,
    );

    // red arc
    final redArcRect = Rect.fromCircle(
      center: center,
      radius: redCircleRadius,
    );
    final redArcpaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round
      ..color = Colors.red.shade400;

    canvas.drawArc(
      redArcRect,
      startingAngle,
      progress * redRandom * pi,
      false,
      redArcpaint,
    );

    // green arc
    final greenArcRect = Rect.fromCircle(
      center: center,
      radius: greenCircleRadius,
    );
    final greenArcpaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round
      ..color = Colors.green.shade400;

    canvas.drawArc(
      greenArcRect,
      startingAngle,
      progress * greenRandom * pi,
      false,
      greenArcpaint,
    );
    // blue arc
    final blueArcRect = Rect.fromCircle(
      center: center,
      radius: blueCircleRadius,
    );
    final blueArcpaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round
      ..color = Colors.cyan.shade400;

    canvas.drawArc(
      blueArcRect,
      startingAngle,
      progress * blueRandom * pi,
      false,
      blueArcpaint,
    );
    // final rect = Rect.fromLTWH(
    //   0,
    //   0,
    //   size.width,
    //   size.height,
    // );

    // final paint = Paint()..color = Colors.blue;

    // canvas.drawRect(rect, paint);

    // final circlePaint = Paint()
    //   ..color = Colors.red
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 20;

    // canvas.drawCircle(
    //   Offset(size.width / 2, size.width / 2),
    //   size.width / 2,
    //   circlePaint,
    // );
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
