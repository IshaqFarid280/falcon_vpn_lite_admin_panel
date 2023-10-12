import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eye_vpn_lite_admin_panel/data/datasource/remote/dio/dio_client.dart';
import 'package:eye_vpn_lite_admin_panel/data/model/base_model/api_response.dart';
import 'package:eye_vpn_lite_admin_panel/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../datasource/remote/exception/api_error_handler.dart';
import 'package:dio/dio.dart' as dio;

class AddServerRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AddServerRepo({required this.dioClient, required this.sharedPreferences});

  /// For Add Server
  Future<ApiResponse> addServer({
    dynamic country,
    dynamic username,
    dynamic password,
    dynamic config,
    dynamic image,
  }) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        "country": country,
        "username": username,
        "password": password,
        "config": config,
        'image': image,
      });

      dynamic response = await dioClient.post(
        AppConstants.addServerUrl,
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
