import 'package:eye_vpn_lite_admin_panel/utils/app_color_resources.dart';
import 'package:eye_vpn_lite_admin_panel/view/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_style.dart';
import '../../widgets/reusable_delete_alert_dialogue.dart';
import '../../widgets/reusable_divider.dart';
import '../responsive/responsive.dart';
import '../server/create_server_screen.dart';
import '../server/edit_server_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorResources.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColorResources.primaryColor,
        title: Text("Admin Dashboard", style: myStyleOxanium(
            ResponsiveUI.isDesktop(context)?18:16,
            AppColorResources.primaryWhite,
            FontWeight.w600),
        ),
        actions: [
          Icon(Icons.person_outline_outlined, size: ResponsiveUI.isDesktop(context)?30:20, color: AppColorResources.primaryGreen,),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Admin", style: myStyleOxanium(
                  ResponsiveUI.isDesktop(context)?15:13,
                  AppColorResources.primaryWhite,
                  FontWeight.w600),
              ),
              Text("admin@gmail.com", style: myStyleOxanium(
                  ResponsiveUI.isDesktop(context)?14:12,
                  AppColorResources.primaryWhite,
                  FontWeight.w600),
              ),
            ],
          ),

          SizedBox(width: 10,),

          /// For Log out
          GestureDetector(
              onTap: (){
                Get.offNamedUntil(LoginScreen.routeName, (route) => false);
              },
              child: Icon(Icons.power_settings_new_outlined, size: ResponsiveUI.isDesktop(context)?30:20, color: AppColorResources.primaryRed,)),

          SizedBox(width: 12,),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Stack(
            children: [
              SizedBox(height: 15,),

              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Servers",
                          style: myStyleOxanium(
                              17,
                              AppColorResources.primaryWhite,
                              FontWeight.w600),
                        ),

                        GestureDetector(
                          onTap: (){
                            Get.toNamed(CreateServerScreen.routeName);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColorResources.primaryGreen,
                            ),
                            child: Text(
                              "+ Add New",
                              style: myStyleOxanium(
                                  15,
                                  AppColorResources.primaryWhite,
                                  FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 15,),

                    /// Table Header
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColorResources.tableHeaderColorGreen,
                      ),
                      child: Row(
                        children: [
                          /// Server Name
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: Text(
                                "Server Name",
                                style: myStyleOxanium(
                                    16,
                                    AppColorResources.primaryBlack,
                                    FontWeight.w600),
                              ),
                            ),
                          ),

                          /// Country
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: Text(
                                "Country",
                                style: myStyleOxanium(
                                    16,
                                    AppColorResources.primaryBlack,
                                    FontWeight.w600),
                              ),
                            ),
                          ),

                          /// Username
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: Text(
                                "Username",
                                style: myStyleOxanium(
                                    16,
                                    AppColorResources.primaryBlack,
                                    FontWeight.w600),
                              ),
                            ),
                          ),

                          /// Password
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: Text(
                                "Password",
                                style: myStyleOxanium(
                                    16,
                                    AppColorResources.primaryBlack,
                                    FontWeight.w600),
                              ),
                            ),
                          ),

                          /// Protocol
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: Text(
                                "Protocol",
                                style: myStyleOxanium(
                                    16,
                                    AppColorResources.primaryBlack,
                                    FontWeight.w600),
                              ),
                            ),
                          ),

                          /// Action
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              //color: AppColorResources.switchColor,
                              alignment: Alignment.center,
                              child: Text(
                                "Action",
                                style: myStyleOxanium(
                                    16,
                                    AppColorResources.primaryBlack,
                                    FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    reusableDivider(),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 112),
                child: ListView(
                  children: [

                    /// Table Body
                    Container(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox.shrink(),
                        itemCount: 30,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {

                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: index % 2 == 0 ? AppColorResources.oddColor : AppColorResources.secondaryGreenAccent,
                                ),
                                child: Row(
                                  children: [

                                    /// Server Name
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/images/eye_vpn_logo.png', height: 30, width: 28,),
                                            SizedBox(width: 8,),
                                            Text(
                                              "Bangla VPN",
                                              style: myStyleOxanium(
                                                  15,
                                                  AppColorResources.primaryBlack,
                                                  FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// Country
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Bangladesh",
                                          style: myStyleOxanium(
                                              15,
                                              AppColorResources.primaryBlack,
                                              FontWeight.w400),
                                        ),
                                      ),
                                    ),

                                    /// Username
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "omitkumar ${index + 1}",
                                          style: myStyleOxanium(
                                              15,
                                              AppColorResources.primaryBlack,
                                              FontWeight.w400),
                                        ),
                                      ),
                                    ),

                                    /// Password
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "***********",
                                          style: myStyleOxanium(
                                              15,
                                              AppColorResources.primaryBlack,
                                              FontWeight.w400),
                                        ),
                                      ),
                                    ),

                                    /// Protocol
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        //color: AppColorResources.secondaryGreenAccent,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "UDP/TCP",
                                          style: myStyleOxanium(
                                              15,
                                              AppColorResources.primaryBlack,
                                              FontWeight.w400),
                                        ),
                                      ),
                                    ),

                                    /// Edit and Delete Button
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              /// For Edit
                                              InkWell(
                                                onTap: (){
                                                  Get.toNamed(EditServerScreen.routeName);
                                                },
                                                child: Container(
                                                  height: ResponsiveUI.isDesktop(
                                                      context)
                                                      ? 30
                                                      : 24,
                                                  width: ResponsiveUI.isDesktop(
                                                      context)
                                                      ? 30
                                                      : 24,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColorResources.primaryGreen),
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 15,
                                                    color: AppColorResources.primaryWhite,
                                                  ),
                                                ),
                                              ),

                                              SizedBox(width: 8,),

                                              /// Delete
                                              InkWell(
                                                onTap: (){
                                                  reusableDeleteAlertDialogue(
                                                      context,
                                                      deleteItemName: 'server',
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      });
                                                },
                                                child: Container(
                                                  height: ResponsiveUI.isDesktop(
                                                      context)
                                                      ? 30
                                                      : 24,
                                                  width: ResponsiveUI.isDesktop(
                                                      context)
                                                      ? 30
                                                      : 24,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColorResources.primaryRed),
                                                  child: Icon(
                                                    Icons.delete_forever_outlined,
                                                    size: 15,
                                                    color: AppColorResources.primaryWhite,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3,),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
