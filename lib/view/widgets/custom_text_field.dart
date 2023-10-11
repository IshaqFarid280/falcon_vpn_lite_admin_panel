import 'package:eye_vpn_lite_admin_panel/utils/app_color_resources.dart';
import 'package:flutter/material.dart';
import '../../utils/app_style.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.style,
    required this.controller,
    this.hintText,
    required this.keyboardType,
    this.textformfiledinitialValue,
    this.textInputAction,
    this.focusNode,
  });

  TextEditingController? controller;
  TextInputType? keyboardType;
  TextStyle? style;
  String? hintText;
  String? textformfiledinitialValue;
  TextInputAction? textInputAction;
  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: textformfiledinitialValue,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This filed is required';
        }
        return null;
      },
      focusNode: focusNode,
      cursorColor: AppColorResources.textFieldTextColor,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      controller: controller,
      style: style ?? myStyleOxanium(14, AppColorResources.primaryWhite, FontWeight.w400),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
        hintText: hintText ?? "Enter category name",
        hintStyle: myStyleOxanium(14, AppColorResources.primaryWhite, FontWeight.w400),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColorResources.primaryWhite),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColorResources.primaryWhite),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColorResources.primaryGreenAccent),
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
