import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  final int index;
  const MusicPlayerDetailScreen({
    super.key,
    required this.index,
  });

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _progressContorller =
      AnimationController(vsync: this, duration: const Duration(minutes: 1))
        ..repeat(
          reverse: true,
        );

  //TODO: .. is cascade operation
  late final AnimationController _marqueeContorller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 20),
  )..repeat(
      reverse: true,
    );

  late final Animation<Offset> _marqueeTween = Tween(
    begin: const Offset(0.1, 0),
    end: const Offset(-0.6, 0),
  ).animate(_marqueeContorller);

  late final AnimationController _playPauseContorller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final AnimationController _menuContorller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
    reverseDuration: const Duration(seconds: 1),
  );

  late final Curve _menuCurve = Curves.easeInOutCubic;

  late final Animation<double> _screenScale = Tween(
    begin: 1.0,
    end: 0.7,
  ).animate(
    CurvedAnimation(
      parent: _menuContorller,
      curve: Interval(
        0.0,
        0.3,
        curve: _menuCurve,
      ),
    ),
  );

  late final Animation<Offset> _screenOffset = Tween(
    begin: Offset.zero,
    end: const Offset(0.5, 0),
  ).animate(
    CurvedAnimation(
      parent: _menuContorller,
      curve: Interval(
        0.2,
        0.4,
        curve: _menuCurve,
      ),
    ),
  );

  late final Animation<double> _closeButtonOpacity = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _menuContorller,
      curve: Interval(
        0.3,
        0.5,
        curve: _menuCurve,
      ),
    ),
  );

  late final List<Animation<Offset>> _menuAnimations = [
    for (var i = 0; i < _menus.length; i++)
      Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _menuContorller,
          curve: Interval(
            0.4 + (0.1 * i),
            0.7 + (0.1 * i),
            curve: _menuCurve,
          ),
        ),
      ),
  ];

  late final Animation<Offset> _logOutSlide = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _menuContorller,
      curve: Interval(
        0.8,
        1.0,
        curve: _menuCurve,
      ),
    ),
  );

  @override
  void dispose() {
    _progressContorller.dispose();
    _marqueeContorller.dispose();
    _menuContorller.dispose();
    super.dispose();
  }

  void _onPlayPauseTap() {
    if (_playPauseContorller.isCompleted) {
      _playPauseContorller.reverse();
    } else {
      _playPauseContorller.forward();
    }
  }

  bool _dragging = false;

  void _toggleDragging() {
    setState(() {
      _dragging = !_dragging;
    });
  }

  final ValueNotifier<double> _volume = ValueNotifier(0);

  late final size = MediaQuery.of(context).size;

  void _onVolumeDragUpdate(DragUpdateDetails details) {
    _volume.value += details.delta.dx;

    _volume.value = _volume.value.clamp(0.0, size.width - 80);
  }

  void _openMenu() {
    _menuContorller.forward();
  }

  void _closeMenu() {
    _menuContorller.reverse();
  }

  final List<Map<String, dynamic>> _menus = [
    {
      "icon": Icons.person,
      "text": "Profile",
    },
    {
      "icon": Icons.notifications,
      "text": "Notifications",
    },
    {
      "icon": Icons.settings,
      "text": "Settings",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            leading: FadeTransition(
              opacity: _closeButtonOpacity,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: _closeMenu,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                for (var i = 0; i < _menus.length; i++) ...[
                  SlideTransition(
                    position: _menuAnimations[i],
                    child: Row(
                      children: [
                        Icon(
                          _menus[i]["icon"],
                          color: Colors.grey.shade200,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _menus[i]["text"],
                          style: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
                const Spacer(),
                SlideTransition(
                  position: _logOutSlide,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Log out",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        SlideTransition(
          position: _screenOffset,
          child: ScaleTransition(
            scale: _screenScale,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Interstellar"),
                actions: [
                  IconButton(
                    onPressed: _openMenu,
                    icon: const Icon(Icons.menu),
                  ),
                ],
              ),
              body: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: "${widget.index}",
                      child: Container(
                        height: 350,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 8),
                            )
                          ],
                          image: DecorationImage(
                            image:
                                AssetImage("assets/covers/${widget.index}.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AnimatedBuilder(
                    animation: _progressContorller,
                    builder: (context, child) => CustomPaint(
                      size: Size(
                        size.width - 80,
                        5,
                      ),
                      painter: ProgressBar(
                        progressValue: _progressContorller.value,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedBuilder(
                    animation: _progressContorller,
                    builder: (context, child) {
                      Duration currentTime = _progressContorller.duration! *
                          _progressContorller.value;
                      String formattedTime =
                          "${currentTime.inMinutes}:${(currentTime.inSeconds % 60).toString().padLeft(2, '0')}";
                      String reformattedTime =
                          "${currentTime.inMinutes}:${(60 - currentTime.inSeconds % 60).toString().padLeft(2, '0')}";

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          children: [
                            Text(
                              formattedTime,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              reformattedTime,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Interstellar",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SlideTransition(
                    position: _marqueeTween,
                    child: const Text(
                      "A Fiilm by Christopher Nolan - 2002 Original Motion Picture SoundTrack",
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: _onPlayPauseTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedIcon(
                          icon: AnimatedIcons.pause_play,
                          progress: _playPauseContorller,
                          size: 60,
                        ),
                        // LottieBuilder.asset(
                        //   "assets/animations/play-lottie.json",
                        //   controller: _playPauseContorller,
                        //   onLoaded: (conposition) {
                        //     _playPauseContorller.duration = conposition.duration;
                        //   },
                        //   width: 200,
                        //   height: 200,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onHorizontalDragUpdate: _onVolumeDragUpdate,
                    onHorizontalDragStart: (_) => _toggleDragging(),
                    onHorizontalDragEnd: (_) => _toggleDragging(),
                    child: AnimatedScale(
                      scale: _dragging ? 1.1 : 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.bounceOut,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ValueListenableBuilder(
                          valueListenable: _volume,
                          builder: (context, value, child) => CustomPaint(
                            size: Size(size.width - 80, 50),
                            painter: VolumePainter(
                              volume: value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressBar extends CustomPainter {
  final double progressValue;

  ProgressBar({
    super.repaint,
    required this.progressValue,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final progress = size.width * progressValue;
    // track bar
    final trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final trackRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(10),
    );

    canvas.drawRRect(trackRRect, trackPaint);

    // progress
    final progressPaint = Paint()
      ..color = Colors.grey.shade500
      ..style = PaintingStyle.fill;

    final progressRRect = RRect.fromLTRBR(
      0,
      0,
      progress,
      size.height,
      const Radius.circular(10),
    );

    canvas.drawRRect(progressRRect, progressPaint);

    // thumb
    canvas.drawCircle(
      Offset(progress, size.height / 2),
      7.5,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}

class VolumePainter extends CustomPainter {
  final double volume;

  VolumePainter({
    super.repaint,
    required this.volume,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = Colors.grey.shade300;

    final bgRect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );

    canvas.drawRect(bgRect, bgPaint);

    final volumnePaint = Paint()..color = Colors.grey.shade500;

    final volumeRect = Rect.fromLTWH(
      0,
      0,
      volume,
      size.height,
    );

    canvas.drawRect(volumeRect, volumnePaint);
  }

  @override
  bool shouldRepaint(covariant VolumePainter oldDelegate) {
    return oldDelegate.volume != volume;
  }
}
