
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixabay_demo/appstyle/app_colors.dart';
import 'package:pixabay_demo/appstyle/app_dimensions.dart';

class ViewDecoration {
  static InputDecoration inputDecorationWithCurve(String fieldName, Color color,
      {required Color borderColor,
      Widget? icon,
      Widget? prefixIcon,
      Widget? suffixIcon,
      EdgeInsetsGeometry? contentPadding,
      TextStyle? hintStyle,
      String? errorText,
      BoxConstraints? prefixBoxConstraints,
      BoxConstraints? suffixBoxConstraints}) {
    return InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixBoxConstraints ?? const BoxConstraints(),
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixBoxConstraints ?? const BoxConstraints(),
        hintText: fieldName,
        errorText: errorText,
        hintStyle: hintStyle ??
            textStyle(
                AppDimensions.d14, AppColors.greyScale, FontWeight.w200),
        filled: true,
        fillColor: color,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
                vertical: AppDimensions.d16.h, horizontal: AppDimensions.d20.w),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius:
                BorderRadius.all(Radius.circular(AppDimensions.d12.r))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius:
                BorderRadius.all(Radius.circular(AppDimensions.d12.r))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius:
                BorderRadius.all(Radius.circular(AppDimensions.d12.r))),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.errorRedColor),
            borderRadius:
                BorderRadius.all(Radius.circular(AppDimensions.d12.r))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.errorRedColor),
            borderRadius:
                BorderRadius.all(Radius.circular(AppDimensions.d12.r))));
  }

  static TextStyle textStyle(double size, Color color, FontWeight fontWeight,
      {TextDecoration decoration = TextDecoration.none}) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: size,
        color: color,
        decoration: decoration,
       );
  }
}