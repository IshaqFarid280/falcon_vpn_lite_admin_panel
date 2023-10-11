import 'package:dio/dio.dart';
import 'package:eye_vpn_lite_admin_panel/controllers/add_server_controller.dart';
import 'package:eye_vpn_lite_admin_panel/controllers/auth_controller.dart';
import 'package:eye_vpn_lite_admin_panel/controllers/server_delete_controller.dart';
import 'package:eye_vpn_lite_admin_panel/controllers/update_admin_profile_controller.dart';
import 'package:eye_vpn_lite_admin_panel/data/repository/add_server_repo.dart';
import 'package:eye_vpn_lite_admin_panel/data/repository/server_update_repo.dart';
import 'package:eye_vpn_lite_admin_panel/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/admin_profile_controller.dart';
import 'controllers/edit_server_controller.dart';
import 'controllers/server_details_controller.dart';
import 'controllers/view_all_server_controller.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/admin_profile_repo.dart';
import 'data/repository/auth_repo.dart';
import 'data/repository/server_delete_repo.dart';
import 'data/repository/server_details_repo.dart';
import 'data/repository/update_admin_profile_repo.dart';
import 'data/repository/view_all_server_repo.dart';


final sl = GetIt.instance;

Future<void> init() async {

  /// Core
  sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  ///Repository
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => AddServerRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ViewAllServerRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ServerDetailsRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ServerDeleteRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => UpdateAdminProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ServerUpdateRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => AdminProfileRepo(dioClient: sl(), sharedPreferences: sl()));


  /// Controller
  Get.lazyPut(() => AuthController(dioClient: sl(), authRepo: sl()), fenix: true);
  Get.lazyPut(() => AddServerController(dioClient: sl(), addServerRepo: sl()), fenix: true);
  Get.lazyPut(() => ViewAllServerController(dioClient: sl(), viewAllServerRepo: sl()), fenix: true);
  Get.lazyPut(() => ServerDetailsController(dioClient: sl(), serverDetailsRepo: sl()), fenix: true);
  Get.lazyPut(() => ServerDeleteController(dioClient: sl(), serverDeleteRepo: sl()), fenix: true);
  Get.lazyPut(() => UpdateAdminProfileController(dioClient: sl(), updateAdminProfileRepo: sl()), fenix: true);
  Get.lazyPut(() => EditServerController(dioClient: sl(), serverUpdateRepo: sl()), fenix: true);
  Get.lazyPut(() => AdminProfileController(dioClient: sl(), adminProfileRepo: sl()), fenix: true);


  /// External pocket lock
  ///
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
