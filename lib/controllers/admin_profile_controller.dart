
import 'package:eye_vpn_lite_admin_panel/data/repository/admin_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/datasource/remote/dio/dio_client.dart';
import '../data/model/base_model/api_response.dart';
import '../data/model/response_model/admin_profile_response_model.dart';

class AdminProfileController extends GetxController{

  final DioClient dioClient;
  final AdminProfileRepo adminProfileRepo;
  bool _isLoading = false;
  AdminProfileResponseModel? _adminProfileResponseModel;

  AdminProfileController({required this.dioClient, required this.adminProfileRepo});

  bool get isLoading => _isLoading;
  AdminProfileResponseModel? get adminProfileResponseModel => _adminProfileResponseModel;

  /// For Get Admin Profile
  Future<dynamic> getAdminProfile({required BuildContext context}) async {

    _isLoading = true;
    update();

    ApiResponse apiResponse = await adminProfileRepo.getAdminProfile();

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      _adminProfileResponseModel = AdminProfileResponseModel.fromJson(apiResponse.response!.data);

      _isLoading = false;
      update();

    } else {
      _isLoading = false;
      update();
    }
    return apiResponse.response!.statusCode;
  }
}