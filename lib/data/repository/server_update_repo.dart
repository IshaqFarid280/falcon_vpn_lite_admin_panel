import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';
import 'package:dio/dio.dart' as dio;

class ServerUpdateRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  ServerUpdateRepo({required this.dioClient,required this.sharedPreferences});

  /// For Server Update
  Future<ApiResponse> serverUpdate({dynamic id, dynamic country, dynamic username, dynamic password, dynamic config, dynamic image}) async {
    try {

      dio.FormData formData = dio.FormData.fromMap({
        "country": country,
        "username": username,
        "password": password,
        "config": config,
        'image': image,
      });

      dynamic response = await dioClient.post(
        AppConstants.serverUpdateUrl+id,
        data: formData,
        options: Options(headers: {
          // "Content-Type": "application/json",
          'Content-Type': 'multipart/form-data',
          "Authorization": "Bearer ${sharedPreferences.getString(AppConstants.token) ?? ""}",
        }),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}