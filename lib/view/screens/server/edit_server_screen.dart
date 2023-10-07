
import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eye_vpn_lite_admin_panel/controllers/server_details_controller.dart';
import 'package:eye_vpn_lite_admin_panel/utils/app_color_resources.dart';
import 'package:eye_vpn_lite_admin_panel/utils/app_style.dart';
import 'package:eye_vpn_lite_admin_panel/view/widgets/custom_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controllers/edit_server_controller.dart';
import '../../../controllers/view_all_server_controller.dart';
import '../dashboard/dashboard_screen.dart';
import '../responsive/responsive.dart';

class EditServerScreen extends StatefulWidget {
  static const String routeName = '/edit_server';
  final dynamic serverID;
  EditServerScreen({super.key, this.serverID});

  @override
  State<EditServerScreen> createState() => _EditServerScreenState();
}

class _EditServerScreenState extends State<EditServerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  dynamic _logoBase64;
  dynamic _pickedFile;
  dynamic _imagePath;

  dynamic apiImage;


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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _load(reLoad: true, context: context);
    });
  }

  /// For Load Data
  _load({required bool reLoad, required BuildContext context}) async{
    final Object? id = ModalRoute.of(context)!.settings.arguments;
    await Get.find<ServerDetailsController>().getServerDetailsData(context: context, id: id.toString()).then((value) {
      if(value == 200){
        initialValueAssignToController();
      }
    });
  }

  initialValueAssignToController(){
    setState(() {
      apiImage = serverDetailsController.serverDetailsResponseModel!.image ?? '';
      editServerController.countryController.text = serverDetailsController.serverDetailsResponseModel!.country ?? '';
      editServerController.usernameController.text = serverDetailsController.serverDetailsResponseModel!.username ?? '';
      editServerController.passwordController.text = serverDetailsController.serverDetailsResponseModel!.password ?? '';
      editServerController.configFileController.text = serverDetailsController.serverDetailsResponseModel!.config ?? '';
    });
  }

  /// For Add Server Data
  serverUpdate({required BuildContext context}) async{
    final Object? id = ModalRoute.of(context)!.settings.arguments;
    await editServerController.serverUpdate(
      id: id.toString(),
      country: editServerController.countryController.text.toString(),
      username: editServerController.usernameController.text.toString(),
      password: editServerController.passwordController.text.toString(),
      config: editServerController.configFileController.text.toString(),
      image: _imagePath != null ?_imagePath.toString():apiImage,
      context: context,
    ).then((value) {
      if(value == 200){
        editServerController.clear(context: context);
        Get.find<ViewAllServerController>().getAllServerData(context: context, pageNo: 1, paginate: 25);
        _logoBase64 = null;
      }
    });
  }

  final editServerController = Get.find<EditServerController>();
  final serverDetailsController = Get.find<ServerDetailsController>();

  @override
  Widget build(BuildContext context) {
    final Object? id = ModalRoute.of(context)!.settings.arguments;

    log("Check Server ID ======> ${id}");

    return Scaffold(
      backgroundColor: AppColorResources.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColorResources.primaryColor,
        title: Text("Edit Server", style: myStyleOxanium(ResponsiveUI.isDesktop(context)?18:16, AppColorResources.primaryWhite, FontWeight.w600),),
        actions: [

          /// For Back
          GestureDetector(
            onTap: (){
              Get.toNamed(DashboardScreen.routeName);
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

                                Text("Edit Server", style: myStyleOxanium(18, AppColorResources.primaryWhite, FontWeight.w600), textAlign: TextAlign.center,),

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
                                          ) :
                                          Container(
                                            alignment: Alignment.center,
                                            height: ResponsiveUI.isDesktop(context) ? 80 : 70,
                                            width: ResponsiveUI.isDesktop(context) ? 80 : 70,
                                            decoration: BoxDecoration(
                                               shape: BoxShape.rectangle,
                                              color: AppColorResources.circleColor,
                                              border: Border.all(width: 1, color: AppColorResources.primaryWhite),
                                            ),
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: "${apiImage}",
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) => Opacity(
                                                  opacity: 0.8,
                                                  child: Shimmer.fromColors(
                                                    baseColor: AppColorResources.drawerItemColor,
                                                    highlightColor: AppColorResources.primaryWhite,
                                                    direction: ShimmerDirection.ltr,
                                                    child: const SizedBox(
                                                      height: 25,
                                                      width: 35,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget: (context, url, error) => Container(
                                                  height: 25,
                                                  width: 35,
                                                  child: Icon(Icons.image_outlined, color: AppColorResources.primaryColor),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ),
                                        _logoBase64 != null|| apiImage != null?Positioned(
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
                                //   alignment: Alignment.centerLeft,
                                //   child: Text("Server Name", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400,),),
                                // ),
                                //
                                // SizedBox(height: 8),
                                //
                                // SizedBox(
                                //   width: double.infinity,
                                //   child: TextFormField(
                                //     controller: editServerController.serverNameController,
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
                                  child: Text("Country Name", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400,),),
                                ),

                                SizedBox(height: 8),

                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: editServerController.countryController,
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
                                  child: Text("Username", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400,),),
                                ),

                                SizedBox(height: 8),

                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: editServerController.usernameController,
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
                                  child: Text("Password", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400),),
                                ),

                                SizedBox(height: 8,),

                                Obx(() => SizedBox(
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
                                      obscureText: editServerController.obscureText.value,
                                      controller: editServerController.passwordController,
                                      obscuringCharacter: '*',
                                      style: myStyleOxanium(14, AppColorResources.hintTextColor, FontWeight.w400),
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            editServerController.changeIcon();
                                          },
                                          child: Icon(
                                            editServerController.obscureText.value ? Icons.visibility_off_rounded : Icons.visibility,
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
                                  child: Text("OVPN Config Script", style: myStyleOxanium(16, AppColorResources.primaryWhite, FontWeight.w400,),),
                                ),

                                SizedBox(height: 8),

                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: editServerController.configFileController,
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

                                /// Login Button
                                CustomButton(
                                  onTap: () async{
                                    if(_formKey.currentState!.validate()){
                                      serverUpdate(context: context);
                                    }
                                  },
                                  title: "Update Server",
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
