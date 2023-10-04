import 'package:flutter/material.dart';
import '../../utils/app_color_resources.dart';


/// For reuse Divider
reusableDivider({Color? color}) {
  return Divider(
    thickness: 1,
    indent: 0,
    endIndent: 0,
    color: color ?? AppColorResources.dividerColor,
  );
}
