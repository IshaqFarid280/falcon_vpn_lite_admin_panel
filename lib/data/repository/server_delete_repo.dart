import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';

class ServerDeleteRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  ServerDeleteRepo({required this.dioClient,required this.sharedPreferences});

  /// For Server Delete
  Future<ApiResponse> serverDelete({dynamic id}) async {
    try {
      dynamic response = await dioClient.post(
        AppConstants.serverDeleteUrl+id,
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