import 'package:eye_vpn_lite_admin_panel/utils/app_constants.dart';
import 'package:eye_vpn_lite_admin_panel/view/screens/auth/login_screen.dart';
import 'package:eye_vpn_lite_admin_panel/view/screens/dashboard/dashboard_screen.dart';
import 'package:eye_vpn_lite_admin_panel/view/screens/server/add_server_screen.dart';
import 'package:eye_vpn_lite_admin_panel/view/screens/server/edit_server_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:url_strategy/url_strategy.dart';
import 'di_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LoginScreen.routeName,
      getPages: [
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(name: DashboardScreen.routeName, page: () => DashboardScreen(), transition: Transition.rightToLeft, transitionDuration: Duration(milliseconds: 500)),
        GetPage(name: CreateServerScreen.routeName, page: () => CreateServerScreen(), transition: Transition.fadeIn, transitionDuration: Duration(milliseconds: 500)),
        GetPage(name: EditServerScreen.routeName, page: () => EditServerScreen(), transition: Transition.rightToLeft, transitionDuration: Duration(milliseconds: 500)),
      ],
    );
  }
}
