import 'package:eye_vpn_lite_admin_panel/data/repository/add_server_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/datasource/remote/dio/dio_client.dart';
import '../data/model/base_model/api_response.dart';
import '../data/model/base_model/error_response.dart';

class AddServerController extends GetxController{
  var serverNameController = TextEditingController();
  var countryController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var configFileController = TextEditingController();
  final DioClient dioClient;
  final AddServerRepo addServerRepo;
  bool _isLoading = false;

  AddServerController({required this.dioClient, required this.addServerRepo});


  RxBool obscureText = true.obs;
  Rx<String> errMsg = ''.obs;

  bool get isLoading => _isLoading;

  /// For Change Icon
  changeIcon() {
    obscureText.value = !obscureText.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    serverNameController.dispose();
    countryController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    configFileController.dispose();
  }

  /// For Clear Text Field
  clear({required BuildContext context}) async{
    countryController.clear();
    usernameController.clear();
    passwordController.clear();
    configFileController.clear();
  }

  /// For Add Server
  Future<dynamic> addServer({dynamic country, dynamic username, dynamic password, dynamic config, dynamic image, required BuildContext context}) async{
    _isLoading = true;
    update();

    ApiResponse apiResponse = await addServerRepo.addServer(country: country, username: username, password: password, config: config, image: image);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 201) {

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