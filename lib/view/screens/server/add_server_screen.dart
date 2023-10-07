
import 'dart:convert';
import 'dart:developer';
import 'package:eye_vpn_lite_admin_panel/controllers/add_server_controller.dart';
import 'package:eye_vpn_lite_admin_panel/utils/app_color_resources.dart';
import 'package:eye_vpn_lite_admin_panel/utils/app_style.dart';
import 'package:eye_vpn_lite_admin_panel/view/widgets/custom_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controllers/view_all_server_controller.dart';
import '../dashboard/dashboard_screen.dart';
import '../responsive/responsive.dart';

class CreateServerScreen extends StatefulWidget {
  static const String routeName = '/add_server';
  CreateServerScreen({super.key});

  @override
  State<CreateServerScreen> createState() => _CreateServerScreenState();
}

class _CreateServerScreenState extends State<CreateServerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  dynamic _logoBase64;
  dynamic _pickedFile;
  dynamic _imagePath;


  void _chooseImage() async {
    _pickedFile = await FilePicker.platform.pickFiles();
    if (_pickedFile != null) {
      try {
        setState(() {
          _logoBase64 = _pickedFile!.files.first.bytes;
          _imagePath = 'data:image/png;base64,' +base64Encode(_logoBase64);
          log(_imagePath);
        });
      } catch (error) {
        log('${error}');
      }
    } else {
      log('No Image Selected');
    }
  }

  /// For Add Server Data
  addServerData({required BuildContext context}) async{
    await addServerController.addServer(
      country: addServerController.countryController.text.toString(),
      username: addServerController.usernameController.text.toString(),
      password: addServerController.passwordController.text.toString(),
      config: addServerController.configFileController.text.toString(),
      image: _imagePath.toString(),
      context: context,
    ).then((value) {
      if(value == 201){
        addServerController.clear(context: context);
        Get.find<ViewAllServerController>().getAllServerData(context: context, pageNo: 1, paginate: 25);
        _logoBase64 = null;
      }
    });
  }

  final addServerController = Get.find<AddServerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorResources.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColorResources.primaryColor,
        title: Text("Add New Server", style: myStyleOxanium(ResponsiveUI.isDesktop(context)?18:16, AppColorResources.primaryWhite, FontWeight.w600),),
        actions: [

          /// For Back
          GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColorResources.primaryGreen,
                ),
                child: Text(
                  "Back",
                  style: myStyleOxanium(
                      15,
                      AppColorResources.primaryWhite,
                      FontWeight.w600),
                ),
              ),
          ),

          SizedBox(width: 12,),
        ],
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
                      width: 650,
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

                                Text("Add New Server", style: myStyleOxanium(18, AppColorResources.primaryWhite, FontWeight.w600), textAlign: TextAlign.center,),

                                SizedBox(height: 20),

                                /// For Pick Image from computer
                                InkWell(
                                  onTap: () {
                                    _chooseImage();
                                  },
                                  child: Container(
                                    height: ResponsiveUI.isDesktop(context) ? 90 : 80,
                                    width: ResponsiveUI.isDesktop(context) ? 90 : 80,
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        ClipOval(
                                          child: _logoBase64 != null // Check if an image is selected
                                              ? Image.memory(Uint8List.fromList(_logoBase64),
                                            height: ResponsiveUI.isDesktop(context) ? 80 : 70,
                                            width: ResponsiveUI.isDesktop(context) ? 80 : 70,
                                            fit: BoxFit.cover,
                                          ) : Container(
                                            alignment: Alignment.center,
                                            height: ResponsiveUI.isDesktop(context) ? 80 : 70,
                                            width: ResponsiveUI.isDesktop(context) ? 80 : 70,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColorResources.circleColor,
                                                border: Border.all(width: 1, color: AppColorResources.primaryWhite)),
                                            child: Icon(
                                              Icons.camera_alt_rounded,
                                              color: AppColorResources.primaryColor,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                        _logoBase64 != null?Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: -45,
                                          child: Container(
                                            height: ResponsiveUI.isDesktop(context) ? 30 : 20,
                                            width: ResponsiveUI.isDesktop(context) ? 30 : 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColorResources.appBarColor,
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.camera_alt_rounded,
                                              color: AppColorResources.primaryWhite,
                                              size: 13,
                                            ),
                                          ),):SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text("Upload Image", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w500),),
                                SizedBox(height: 20,),

                                /// Server Name
                                // Align(
                                //     alignment: Alignment.centerLeft,
                                //     child: Row(
                                //       children: [
                                //         Text("Server Name", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400,),),
                                //         Text("*", style: myStyleOxanium(16, AppColorResources.primaryRed, FontWeight.w400,),),
                                //       ],
                                //     ),
                                // ),
                                //
                                // SizedBox(height: 8),
                                //
                                // SizedBox(
                                //   width: double.infinity,
                                //   child: TextFormField(
                                //     controller: createServerController.serverNameController,
                                //     validator: (value) {
                                //       if (value == null || value.isEmpty) {
                                //         return 'This filed is required';
                                //       }
                                //       return null;
                                //     },
                                //     cursorColor: AppColorResources.hintTextColor,
                                //     keyboardType: TextInputType.text,
                                //     textInputAction: TextInputAction.next,
                                //     style: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
                                //     decoration: InputDecoration(
                                //       contentPadding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                                //       hintText: "Enter server name",
                                //       hintStyle: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
                                //       border: OutlineInputBorder(
                                //           borderSide: BorderSide(width: 1, color: AppColorResources.borderColor),
                                //           borderRadius: BorderRadius.circular(5)),
                                //       enabledBorder: OutlineInputBorder(
                                //           borderSide: BorderSide(width: 1, color: AppColorResources.borderColor),
                                //           borderRadius: BorderRadius.circular(5)),
                                //       focusedBorder: OutlineInputBorder(
                                //           borderSide: BorderSide(width: 1, color: AppColorResources.borderColor),
                                //           borderRadius: BorderRadius.circular(5)),
                                //     ),
                                //   ),
                                // ),
                                //
                                // SizedBox(height: 20),

                                /// Country Name
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text("Country Name", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400,),),
                                      Text("*", style: myStyleOxanium(16, AppColorResources.primaryRed, FontWeight.w400,),),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 8),

                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: addServerController.countryController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This filed is required';
                                      }
                                      return null;
                                    },
                                    cursorColor: AppColorResources.hintTextColor,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                                      hintText: "Enter country name",
                                      hintStyle: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
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

                                /// Username
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text("Username", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400,),),
                                      Text("*", style: myStyleOxanium(16, AppColorResources.primaryRed, FontWeight.w400,),),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 8),

                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: addServerController.usernameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This filed is required';
                                      }
                                      return null;
                                    },
                                    cursorColor: AppColorResources.hintTextColor,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                                      hintText: "Enter username",
                                      hintStyle: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
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
                                        Text("*", style: myStyleOxanium(16, AppColorResources.primaryRed, FontWeight.w400,),),
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
                                          return 'This filed is required';
                                        }
                                        return null;
                                      },
                                      cursorColor: AppColorResources.hintTextColor,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      obscureText: addServerController.obscureText.value,
                                      controller: addServerController.passwordController,
                                      obscuringCharacter: '*',
                                      style: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            addServerController.changeIcon();
                                          },
                                          child: Icon(
                                            addServerController.obscureText.value ? Icons.visibility_off_rounded : Icons.visibility,
                                            color: AppColorResources.hintTextColor,
                                            size: 18,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                                        hintText: "Enter password",
                                        hintStyle: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
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

                                SizedBox(height: 20),

                                /// Config File
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text("OVPN Config Script", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400,),),
                                      Text("*", style: myStyleOxanium(16, AppColorResources.primaryRed, FontWeight.w400,),),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 8),

                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: addServerController.configFileController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This filed is required';
                                      }
                                      return null;
                                    },
                                    cursorColor: AppColorResources.hintTextColor,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    maxLines: null,
                                    style: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                                      hintText: "Enter OVPN config script",
                                      hintStyle: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
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

                                SizedBox(height: 30,),

                                /// Add Server Button
                                CustomButton(
                                  onTap: () async{
                                    if(_formKey.currentState!.validate()){
                                      addServerData(context: context);
                                    }
                                  },
                                  title: "Add Server",
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
