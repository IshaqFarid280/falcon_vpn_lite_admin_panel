
import 'package:eye_vpn_lite_admin_panel/utils/app_color_resources.dart';
import 'package:eye_vpn_lite_admin_panel/utils/app_style.dart';
import 'package:eye_vpn_lite_admin_panel/view/screens/dashboard/dashboard_screen.dart';
import 'package:eye_vpn_lite_admin_panel/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final loginController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorResources.bgColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 8,
                    child: Container(
                      width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColorResources.primaryColor,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 10,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                              color: AppColorResources.primaryGreen,
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [

                                Image.asset('assets/images/eye_vpn_logo.png', height: 55, width: 55,),

                                SizedBox(height: 10),

                                Text("Login to Eye VPN Lite Admin Panel", style: myStyleOxanium(
                                    18,
                                    AppColorResources.primaryWhite,
                                    FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: 25),

                                /// Email Field
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text("Email", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400,),),
                                        Text("*", style: myStyleOxanium(16, AppColorResources.primaryRed, FontWeight.w400,),),
                                      ],
                                    )),

                                SizedBox(height: 8),

                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: loginController.emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This filed must not be empty';
                                      }
                                      return null;
                                    },
                                    cursorColor: AppColorResources.hintTextColor,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    style: myStyleOxanium(
                                        14,
                                        AppColorResources.hintTextColor,
                                        FontWeight.w400),
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.person,
                                        color: AppColorResources.hintTextColor,
                                        size: 18,
                                      ),
                                      contentPadding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                                      hintText: "Enter Your email",
                                      hintStyle: myStyleOxanium(
                                          14,
                                          AppColorResources.hintTextColor,
                                          FontWeight.w400),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1, color: AppColorResources.borderColor),
                                          borderRadius: BorderRadius.circular(5)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1, color: AppColorResources.borderColor),
                                          borderRadius: BorderRadius.circular(5)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1, color: AppColorResources.borderColor),
                                          borderRadius: BorderRadius.circular(5)),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20),

                                /// Password Field
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text("Password", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400),),
                                        Text("*", style: myStyleOxanium(16, AppColorResources.primaryRed, FontWeight.w400),),
                                      ],
                                    ),
                                ),
                                SizedBox(height: 8,),

                                Obx(
                                      () => SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This filed must not be empty';
                                        }
                                        return null;
                                      },
                                      cursorColor: AppColorResources.hintTextColor,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      obscureText: loginController.obscureText.value,
                                      controller: loginController.passwordController,
                                      obscuringCharacter: '*',
                                      style: myStyleOxanium(
                                          14,
                                          AppColorResources.hintTextColor,
                                          FontWeight.w400),
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            loginController.changeIcon();
                                          },
                                          child: Icon(
                                            loginController.obscureText.value ? Icons.visibility_off_rounded : Icons.visibility,
                                            color: AppColorResources.hintTextColor,
                                            size: 18,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                                        hintText: "Enter Your Password",
                                        hintStyle: myStyleOxanium(
                                            14,
                                            AppColorResources.hintTextColor,
                                            FontWeight.w400),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1, color: AppColorResources.borderColor),
                                            borderRadius: BorderRadius.circular(5)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1, color: AppColorResources.borderColor),
                                            borderRadius: BorderRadius.circular(5)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1, color: AppColorResources.borderColor),
                                            borderRadius: BorderRadius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 30,),

                                /// Login Button
                                CustomButton(
                                  onTap: () async{
                                    // if(loginController.formKey.currentState!.validate()){
                                    // }
                                    Get.offNamedUntil(DashboardScreen.routeName, (route) => false);
                                  },
                                  title: "Login",
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: 10,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                              color: AppColorResources.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
