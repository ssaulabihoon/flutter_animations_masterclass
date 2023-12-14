import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveScreen extends StatefulWidget {
  const RiveScreen({super.key});

  @override
  State<RiveScreen> createState() => _RiveScreenState();
}

class _RiveScreenState extends State<RiveScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          RiveAnimation.asset(
            "assets/animations/custom-button-animation.riv",
            stateMachines: ["state"],
          ),
          Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// late final StateMachineController _stateMachineController;

//   void _onInit(Artboard artboard) {
//     _stateMachineController = StateMachineController.fromArtboard(
//         artboard, "State Machine 1",
//         onStateChange: (stateMachineName, stateName) {})!;

//     artboard.addController(_stateMachineController);
//   }

//   void _toggelPanel() {
//     final input = _stateMachineController.findInput<bool>("panelActive")!;

//     input.change(!input.value);
//   }

//   @override
//   void dispose() {
//     _stateMachineController.dispose();
//     super.dispose();
//   }
// Scaffold(
//       appBar: AppBar(
//         title: const Text('Rive'),
//       ),
//       body: Stack(
//         children: [
//           const RiveAnimation.asset(
//             "assets/animations/balls-animation.riv",
//             fit: BoxFit.cover,
//           ),
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(
//                 sigmaX: 50,
//                 sigmaY: 50,
//               ),
//               child: const Center(
//                 child: Text(
//                   "Welcome to AI App",
//                   style: TextStyle(
//                     fontSize: 28,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );

//  SizedBox(
//               height: 500,
//               width: double.infinity,
//               child: RiveAnimation.asset(
//                 "assets/animations/old-man-animation.riv",
//                 artboard: "Dwarf Panel",
//                 stateMachines: const ["State Machine 1"],
//                 onInit: _onInit,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: _toggelPanel,
//               child: const Text('Go!'),
//             ),

// Center(
//         child: Container(
//           color: const Color(0xFFFF2ECC),
//           width: double.infinity,
//           child: RiveAnimation.asset(
//             "assets/animations/stars-animation.riv",
//             artboard: "New Artboard",
//             stateMachines: const ["State Machine 1"],
//             onInit: _onInit,
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
