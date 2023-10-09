import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';

class AdminProfileRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AdminProfileRepo({required this.dioClient,required this.sharedPreferences});

  /// For Get Admin Profile
  Future<ApiResponse> getAdminProfile() async {
    try {
      dynamic response = await dioClient.get(
        AppConstants.adminProfileUrl,
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