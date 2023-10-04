import 'package:eye_vpn_lite_admin_panel/view/widgets/reusable_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_color_resources.dart';
import '../../utils/app_style.dart';

reusableDeleteAlertDialogue(BuildContext context, {required String deleteItemName, required VoidCallback onTap}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          scrollable: true,
          backgroundColor: AppColorResources.primaryWhite,
          alignment: Alignment.center,
          title: Center(
            child: Text(
              "Please Confirm",
              style: myStyleOxanium(
                16,
                AppColorResources.viewButtonColor,
                FontWeight.w600,
              ),
            ),
          ),
          content: Text(
            "Are you sure you want to delete this $deleteItemName",
            style: myStyleOxanium(
              14,
              AppColorResources.primaryBlack,
              FontWeight.w500,
            ),
          ),
          actions: [
            reusableDivider(
              color: AppColorResources.buttonColorRed,
            ),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        alignment: Alignment.center,
                        child: Text(
                          "Yes",
                          style: myStyleOxanium(
                            14,
                            AppColorResources.primaryRed,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    )),
                Container(
                  height: 30,
                  width: 2,
                  color: AppColorResources.buttonColorRed,
                ),
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        alignment: Alignment.center,
                        child: Text(
                          "No",
                          style: myStyleOxanium(
                            14,
                            AppColorResources.primaryGreen,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        );
      });
}
