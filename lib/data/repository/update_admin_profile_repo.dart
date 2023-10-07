import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';

class UpdateAdminProfileRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  UpdateAdminProfileRepo({required this.dioClient,required this.sharedPreferences});

  /// For Update Admin Profile
  Future<ApiResponse> updateAdminProfile({dynamic email, dynamic name}) async {
    try {
      dynamic response = await dioClient.post(
        AppConstants.updateServerUrl,
        data: {
          "email": email,
          "name": name,
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