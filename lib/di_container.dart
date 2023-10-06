import 'package:dio/dio.dart';
import 'package:eye_vpn_lite_admin_panel/controllers/auth_controller.dart';
import 'package:eye_vpn_lite_admin_panel/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/create_server_controller.dart';
import 'controllers/edit_server_controller.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/auth_repo.dart';


final sl = GetIt.instance;

Future<void> init() async {
  /// Core
  sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  ///Repository
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));



  /// Controller
  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => CreateServerController(), fenix: true);
  Get.lazyPut(() => EditServerController(), fenix: true);

  // Get.lazyPut(() => AuthController(authRepo: sl(), dioClient: sl()),fenix: true);


  /// External pocket lock
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
