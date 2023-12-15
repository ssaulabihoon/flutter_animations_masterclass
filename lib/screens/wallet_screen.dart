import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animations_masterclass/screens/container_transform_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

List<Color> colors = [
  Colors.black,
  Colors.purple,
  Colors.blue,
];

class _WalletScreenState extends State<WalletScreen> {
  bool _isExpanded = false;

  void _onExpand() {
    setState(() {
      _isExpanded = true;
    });
  }

  void _onShrink() {
    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: _onExpand,
          onVerticalDragEnd: (_) => _onShrink(),
          child: Column(
            children: [
              for (var index in [0, 1, 2])
                Hero(
                  tag: "$index",
                  child: CreditCard(
                    index: index,
                    isExpanded: _isExpanded,
                  )
                      .animate(
                        target: _isExpanded ? 0 : 1,
                        delay: 1.5.seconds,
                      )
                      .flipV(
                        end: 0.1,
                      )
                      .slideY(
                        end: -0.8 * index,
                      ),
                ),
            ]
                .animate(
                  interval: 500.ms,
                )
                .fadeIn(begin: 0)
                .slideX(begin: -1, end: 0),
          ),
        ),
      ),
    );
  }
}

class CreditCard extends StatefulWidget {
  final int index;
  final bool isExpanded;
  const CreditCard({
    super.key,
    required this.index,
    required this.isExpanded,
  });

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  void _onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(
          index: widget.index,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AbsorbPointer(
        absorbing: !widget.isExpanded,
        child: GestureDetector(
          onTap: _onTap,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors[widget.index],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 40,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ian Cards',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '**** **** **22',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 20,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardDetailScreen extends StatelessWidget {
  final int index;
  const CardDetailScreen({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Hero(
              tag: "$index",
              child: CreditCard(
                index: index,
                isExpanded: true,
              ),
            ),
            ...[
              for (var i in [1, 1, 1, 1, 1, 1])
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: ListTile(
                    tileColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      "Uniqlo",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Gangnam Branch",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    trailing: const Text(
                      "\$232,334",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ]
                .animate(
                  interval: 500.ms,
                )
                .fadeIn(
                  begin: 0,
                )
                .flipV(
                  begin: -0.5,
                  end: 0,
                  curve: Curves.bounceOut,
                ),
          ],
        ),
      ),
    );
  }
}

// effects: [
//             FadeEffect(
//               begin: 0,
//               end: 1,
//               duration: 3.seconds,
//               curve: Curves.easeInCubic,
//             ),
//             ScaleEffect(
//               alignment: Alignment.center,
//               begin: Offset.zero,
//               end: const Offset(1, 1),
//               duration: 3.seconds,
//             ),
//           ],

// Center(
//         child: const Text(
//           'Hello!',
//           style: TextStyle(
//             fontSize: 66,
//           ),
//         )
//             .animate()
//             .fadeIn(
//               begin: 0,
//               duration: 3.seconds,
//             )
//             .scale(
//               alignment: Alignment.center,
//               begin: Offset.zero,
//               duration: 3.seconds,
//               end: const Offset(1, 1),
//             )
//             .then(delay: 3.seconds)
//             .slideX(
//               begin: 0,
//               end: -10,
//               duration: 2.seconds,
//             ),
//       ),

// AnimateList(
//           interval: 500.ms,
//           effects: [
//             const SlideEffect(
//               begin: Offset(-1, 0),
//               end: Offset.zero,
//             ),
//             const FadeEffect(begin: 0, end: 1),
//           ],
//           children: [
//             const CreditCard(bgColor: Colors.purple),
//             const CreditCard(bgColor: Colors.black),
//             const CreditCard(bgColor: Colors.blue),
//           ],
//         )
