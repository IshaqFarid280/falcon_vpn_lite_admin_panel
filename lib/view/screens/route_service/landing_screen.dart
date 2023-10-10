// import 'package:beamer/beamer.dart';
// import 'package:eye_vpn_lite_admin_panel/view/screens/auth/login_screen.dart';
// import 'package:eye_vpn_lite_admin_panel/view/screens/dashboard/dashboard_screen.dart';
// import 'package:eye_vpn_lite_admin_panel/view/screens/server/add_server_screen.dart';
// import 'package:eye_vpn_lite_admin_panel/view/screens/server/edit_server_screen.dart';
// import 'package:flutter/material.dart';
//
// class LandingScreen extends StatefulWidget {
//   const LandingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LandingScreen> createState() => _LandingScreenState();
// }
//
// class _LandingScreenState extends State<LandingScreen> {
//   final _beamerKey = GlobalKey<BeamerState>();
//   @override
//   Widget build(BuildContext context) {
//     return Beamer(
//       key: _beamerKey,
//       routerDelegate: BeamerDelegate(
//         // NOTE First Method
//         locationBuilder: RoutesLocationBuilder(
//           routes: {
//             '*': (context, state, data) => LoginScreen(),
//             '/dashboard': (context, state, data) =>  BeamPage(
//               key: ValueKey('Dashboard'),
//               type: BeamPageType.scaleTransition,
//               child: DashboardScreen(),
//             ),
//             '/add-server': (context, state, data) =>  BeamPage(
//               key: ValueKey('add-server'),
//               type: BeamPageType.scaleTransition,
//               child: CreateServerScreen(),
//             ),
//             '/edit-server': (context, state, data) =>  BeamPage(
//               key: ValueKey('edit-server'),
//               type: BeamPageType.scaleTransition,
//               child: EditServerScreen(),
//             ),
//
//           },
//         ),
//
//       ),
//     );
//   }
// }
