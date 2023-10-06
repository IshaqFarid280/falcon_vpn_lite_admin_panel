import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';

class AddServerRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AddServerRepo({required this.dioClient,required this.sharedPreferences});

  /// For Add Server
  Future<ApiResponse> addServer({dynamic country, dynamic username, dynamic password, dynamic config, dynamic image}) async {
    try {
      dynamic response = await dioClient.post(
        AppConstants.addServerUrl,
        data: {
          "country": country,
          "username": username,
          "password": password,
          "config": config,
          "image": image,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${sharedPreferences.getString(AppConstants.token) ?? ""}",
        }),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}