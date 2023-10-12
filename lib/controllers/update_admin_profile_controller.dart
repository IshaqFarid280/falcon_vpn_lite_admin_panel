import 'package:eye_vpn_lite_admin_panel/data/repository/update_admin_profile_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/datasource/remote/dio/dio_client.dart';
import '../data/model/base_model/api_response.dart';
import '../data/model/base_model/error_response.dart';

class UpdateAdminProfileController extends GetxController{
  final DioClient dioClient;
  final UpdateAdminProfileRepo updateAdminProfileRepo;
  bool _isLoading = false;

  UpdateAdminProfileController({required this.dioClient, required this.updateAdminProfileRepo});

  bool get inLoading => _isLoading;

  /// For Update Admin Profile
  Future<dynamic> updateAdminProfile({dynamic email, dynamic name, required BuildContext context}) async{
    _isLoading = true;
    update();

    ApiResponse apiResponse = await updateAdminProfileRepo.updateAdminProfile(email: email, name: name);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      Map map = apiResponse.response!.data;
      update();

      String message = '';

      try{
        message = map["message"];

        if(kDebugMode){
          print("--------------message----------------------->>>>>$message");
        }

        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          elevation: 6.0,
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).primaryColor,
        ));
      }catch(e){
        rethrow;
      }
      update();
    }
    else {
      _isLoading = false;
      update();
      String errorMessage;
      if (apiResponse.error is String) {
        if (kDebugMode) {
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(apiResponse.response!.data["message"]),
          elevation: 6.0,
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).primaryColor,
        ));
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ));
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        if (kDebugMode) {
          print(errorResponse.error![0].message);
        }
        errorMessage = errorResponse.error![0].message;
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ));
      }
      update();
    }
    return apiResponse.response!.statusCode;
  }


}