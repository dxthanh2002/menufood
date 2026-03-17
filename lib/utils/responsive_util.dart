import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context, double p) =>
      MediaQuery.sizeOf(context).width * p;

  static double height(BuildContext context, double p) =>
      MediaQuery.sizeOf(context).height * p;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1024;

  static double scale(BuildContext context, double size) {
    double minDim = MediaQuery.sizeOf(context).width;
    // Scale factor based on standard mobile width (375px)
    return size * (minDim / 375);
  }
}
