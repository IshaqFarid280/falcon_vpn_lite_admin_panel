
import 'package:eye_vpn_lite_admin_panel/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';


class AuthRepo{

  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.dioClient,required this.sharedPreferences});


  /// For Admin Login
  Future<ApiResponse> adminLogin({dynamic email, dynamic password}) async {
    try {
       dynamic response = await dioClient.post(
        AppConstants.loginUrl,
        data: {
          "email": email,
          "password": password,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// For  user token
  Future<void> saveUserToken(String token) async {
    dioClient.updateHeader(token, "");
    try {
      await sharedPreferences.setString(AppConstants.token, token);
      print("========>Token Stored<=======");
      print(await sharedPreferences.getString(AppConstants.token));
    } catch (e) {
      throw e;
    }
  }

  /// save user token in local storage
  getUserToken() {
    SharedPreferences.getInstance();
    dioClient.updateHeader(sharedPreferences.getString(AppConstants.token) ?? "", "");
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  /// remove user token from local storage
  removeUserToken() async{
    await SharedPreferences.getInstance();
    return sharedPreferences.remove(AppConstants.token);
  }

  /// For save auth token
  Future<void> saveAuthToken(String token) async {
    dioClient.token = token;
    dioClient.dio!.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    try {
      await sharedPreferences.setString(AppConstants.token, token);
    } catch (e) {
      throw e;
    }
  }

  /// For Get Auth Token
  String getAuthToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }


}