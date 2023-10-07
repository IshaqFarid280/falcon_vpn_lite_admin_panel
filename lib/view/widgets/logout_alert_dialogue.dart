
import 'package:eye_vpn_lite_admin_panel/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_color_resources.dart';
import '../screens/auth/login_screen.dart';

logoutAlert(BuildContext context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          content: Container(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Log Out", style: myStyleOxanium(18, AppColorResources.primaryColor, FontWeight.w500),),
                  ),
                  Divider(),
                  SizedBox(height: 10,),
                  Text("Are you sure you want to log out?", style: myStyleOxanium(15, AppColorResources.primaryBlack),
                    textAlign: TextAlign.center,),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColorResources.primaryColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Text("No", style: myStyleOxanium(14, AppColorResources.secondaryBlack),),
                        ),
                      ),
                      InkWell(
                        onTap: () async{
                          SharedPreferences _token = await SharedPreferences.getInstance();
                          await _token.clear();
                          Get.offNamedUntil(LoginScreen.routeName, (route) => false);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 28),
                          alignment: Alignment.center,
                          height: 30,
                          decoration: BoxDecoration(
                              color: AppColorResources.primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Text("Yes", style: myStyleOxanium(14, AppColorResources.primaryWhite),),
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        );
      });
}