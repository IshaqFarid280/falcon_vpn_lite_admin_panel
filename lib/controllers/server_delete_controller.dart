import 'package:eye_vpn_lite_admin_panel/controllers/view_all_server_controller.dart';
import 'package:eye_vpn_lite_admin_panel/data/repository/server_delete_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/datasource/remote/dio/dio_client.dart';
import '../data/model/base_model/api_response.dart';
import '../data/model/base_model/error_response.dart';

class ServerDeleteController extends GetxController{
  final DioClient dioClient;
  final ServerDeleteRepo serverDeleteRepo;
  bool _isLoading = false;

  ServerDeleteController({required this.dioClient, required this.serverDeleteRepo});

  bool get isLoading => _isLoading;

  /// For Server Delete
  Future<dynamic> serverDelete({dynamic id, required BuildContext context}) async{
    _isLoading = true;
    update();

    ApiResponse apiResponse = await serverDeleteRepo.serverDelete(id: id.toString());

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

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

      }
      update();
    }
    else {
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

  /// For Delete Server
  deleteServer({required BuildContext context, dynamic id}) async{
    await serverDelete(context: context, id: id.toString()).then((value) {
      if(value == 200){
        Get.find<ViewAllServerController>().resetPage();
        Get.find<ViewAllServerController>().clearList();
        Get.find<ViewAllServerController>().getAllServerData(context: context, pageNo: 1, paginate: 25);
        Get.back();
      }
    });
  }

}