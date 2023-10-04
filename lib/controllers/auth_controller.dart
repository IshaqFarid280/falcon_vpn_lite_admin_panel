import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  RxBool obscureText = true.obs;
  Rx<String> errMsg = ''.obs;

  changeIcon() {
    obscureText.value = !obscureText.value;
  }



}