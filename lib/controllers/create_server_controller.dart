import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateServerController extends GetxController{
  var serverNameController = TextEditingController();
  var countryController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var configFileController = TextEditingController();


  RxBool obscureText = true.obs;
  Rx<String> errMsg = ''.obs;

  changeIcon() {
    obscureText.value = !obscureText.value;
  }



}