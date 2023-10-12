import 'package:flutter/material.dart';
import '../../utils/app_color_resources.dart';
import '../../utils/app_style.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.color,
      required this.title,
      required this.onTap,
      this.width});

  Color? color;
  Widget? title;
  VoidCallback? onTap;
  double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: width ?? 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? AppColorResources.primaryGreen,
        ),
        child: title,
      ),
    );
  }
}
