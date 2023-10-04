import 'package:flutter/material.dart';

/// Responsive UI for any platform
class ResponsiveUI extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveUI({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  /// For Mobile
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 480;

  /// For Tablet
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 480 &&
      MediaQuery.of(context).size.width <= 800;

  /// For Desktop
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 800;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width > 800) {
      return desktop!;
    } else if (size.width > 480 && tablet != null) {
      return tablet!;
    } else {
      return mobile!;
    }
  }
}
