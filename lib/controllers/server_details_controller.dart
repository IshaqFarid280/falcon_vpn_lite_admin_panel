
import 'package:eye_vpn_lite_admin_panel/data/repository/server_details_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/datasource/remote/dio/dio_client.dart';
import '../data/model/base_model/api_response.dart';
import '../data/model/response_model/server_details_response_model.dart';

class ServerDetailsController extends GetxController{

  final DioClient dioClient;
  final ServerDetailsRepo serverDetailsRepo;
  bool _isLoading = false;
  ServerDetailsResponseModel? _serverDetailsResponseModel;

  ServerDetailsController({required this.dioClient, required this.serverDetailsRepo});

  bool get isLoading => _isLoading;
  ServerDetailsResponseModel? get serverDetailsResponseModel => _serverDetailsResponseModel;

  /// For Get Server Details Data
  Future<dynamic> getServerDetailsData({required BuildContext context, required dynamic id}) async {

    _isLoading = true;
    update();

    ApiResponse apiResponse = await serverDetailsRepo.getServerDetailsData(id: id);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      _serverDetailsResponseModel = ServerDetailsResponseModel.fromJson(apiResponse.response!.data);

      _isLoading = false;
      update();

    } else {
      _isLoading = false;
      update();
    }
    return apiResponse.response!.statusCode;
  }
}