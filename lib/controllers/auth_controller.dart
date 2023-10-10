import 'dart:developer';
import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/datasource/remote/dio/dio_client.dart';
import '../data/model/base_model/api_response.dart';
import '../data/model/base_model/error_response.dart';
import '../data/repository/auth_repo.dart';
import '../view/screens/dashboard/dashboard_screen.dart';

class AuthController extends GetxController{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final DioClient dioClient;
  final AuthRepo authRepo;
  bool _isLoading = false;

  AuthController({required this.dioClient, required this.authRepo});

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
    emailController.dispose();
    passwordController.dispose();
  }

  /// For Login
  Future<dynamic> adminLogin({required dynamic email, required dynamic password, required BuildContext context}) async{
    _isLoading = true;
    update();

    ApiResponse apiResponse = await authRepo.adminLogin(email: email, password: password);

    if(apiResponse.response != null && apiResponse.response!.statusCode == 200){
      _isLoading = false;
      Map map = apiResponse.response!.data;

      String token = '';
      String message = '';

      try{
        message = map["message"];
        token = map["token"];

        if(kDebugMode){
          print("--------------message----------------------->>>>>$message");
          print("--------------token----------------------->>>>>$token");
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

      if(token.isNotEmpty){
        authRepo.saveUserToken(token);
      }
      update();
    }

    else{
      _isLoading = false;
      update();
      if(apiResponse.response != null && apiResponse.response!.statusCode == 200){
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(apiResponse.response!.data["message"]),
          elevation: 6.0,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }

      String errorMessage;
      if(apiResponse.error is String){
        if(kDebugMode){
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${errorMessage}'),
          backgroundColor: Colors.red,
        ));
      }
      else{
        ErrorResponse errorResponse = apiResponse.error;
        if(kDebugMode){
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
    if (kDebugMode) {
      print("response.statusCode${apiResponse.response!.statusCode}");
    }
    return apiResponse.response!.statusCode;
  }

  /// For auth token
  Future authToken(String authToken ) async{
    authRepo.saveAuthToken(authToken);
    update();
  }

  /// Get user token
  dynamic getUserToken(){
    log(authRepo.getUserToken());
    return authRepo.getUserToken();
  }


  /// For Admin Login Data
  loginData({required BuildContext context}) async{
    await adminLogin(
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
      context: context,
    ).then((value) {
      if(value == 200){
        Get.offNamedUntil(DashboardScreen.routeName, (route) => false);
        //Beamer.of(context).beamToReplacementNamed('/dashboard');
      }
    });
  }

}