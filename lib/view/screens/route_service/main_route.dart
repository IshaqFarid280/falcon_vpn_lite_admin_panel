// import 'package:beamer/beamer.dart';
// import 'package:eye_vpn_lite_admin_panel/view/screens/auth/login_screen.dart';
// import 'package:eye_vpn_lite_admin_panel/view/screens/dashboard/dashboard_screen.dart';
// import 'package:eye_vpn_lite_admin_panel/view/screens/route_service/landing_screen.dart';
// import 'package:eye_vpn_lite_admin_panel/view/screens/server/add_server_screen.dart';
// import 'package:eye_vpn_lite_admin_panel/view/screens/server/edit_server_screen.dart';
// import 'package:flutter/material.dart';
//
// class LoginLocation extends BeamLocation<BeamState> {
//   LoginLocation(RouteInformation routeInformation) : super(routeInformation);
//   @override
//   List<BeamPage> buildPages(BuildContext context, BeamState state) {
//     return [
//       BeamPage(
//           key: ValueKey('login'),
//           child:  LandingScreen()),
//     ];
//   }
//
//   @override
//   List<Pattern> get pathPatterns => ['/*'];
// }
//
// class DashboardLocation extends BeamLocation<BeamState> {
//   DashboardLocation(RouteInformation routeInformation)
//       : super(routeInformation);
//   @override
//   List<BeamPage> buildPages(BuildContext context, BeamState state) {
//     return [
//       BeamPage(
//           key: ValueKey('dashboard'),
//           child: DashboardScreen(),
//           type: BeamPageType.scaleTransition),
//     ];
//   }
//
//   @override
//   List<Pattern> get pathPatterns => ['/dashboard*'];
// }
//
//
// class AddServerLocation extends BeamLocation<BeamState> {
//   AddServerLocation(RouteInformation routeInformation)
//       : super(routeInformation);
//   @override
//   List<BeamPage> buildPages(BuildContext context, BeamState state) {
//     return [
//       BeamPage(
//           key: ValueKey('add-server'),
//           child: CreateServerScreen(),
//           type: BeamPageType.scaleTransition),
//     ];
//   }
//
//   @override
//   List<Pattern> get pathPatterns => ['/add-server*'];
// }
//
// class EditServerLocation extends BeamLocation<BeamState> {
//   EditServerLocation(RouteInformation routeInformation)
//       : super(routeInformation);
//   @override
//   List<BeamPage> buildPages(BuildContext context, BeamState state) {
//     return [
//       BeamPage(
//           key: ValueKey('edit-server'),
//           child: EditServerScreen(),
//           type: BeamPageType.scaleTransition),
//     ];
//   }
//
//   @override
//   List<Pattern> get pathPatterns => ['/edit-server*'];
// }