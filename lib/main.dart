import 'package:advanced_navigator/advanced_navigator.dart';
import 'package:eye_vpn_lite_admin_panel/utils/app_constants.dart';
import 'package:eye_vpn_lite_admin_panel/view/screens/auth/login_screen.dart';
import 'package:eye_vpn_lite_admin_panel/view/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
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
      // builder: (context, _) => AdvancedNavigator(
      //   tag: 'root',
      //   paths: {
      //     '/': (_) => [
      //       CupertinoPage(key: ValueKey('login'), child: LoginScreen()),
      //     ],
      //     '/dashboard_screen': (_) => [
      //       CupertinoPage(key: ValueKey('dashboard'), child: DashboardScreen()),
      //     ],
      //   },
      // ),
      initialRoute: LoginScreen.routeName,
      getPages: [
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(name: DashboardScreen.routeName, page: () => DashboardScreen()),
      ],
    );
  }
}
