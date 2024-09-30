import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pixabay_demo/appstyle/app_colors.dart';
import 'package:pixabay_demo/appstyle/app_dimensions.dart';
import 'package:pixabay_demo/appstyle/app_extentions.dart';

class DialogHelper {
  static Flushbar? myFlushBar;

  static void message(String message, {Color? color, Color? bgColor}) {
    dismissFlushBar();
    myFlushBar = Flushbar(
      messageText: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.info, color: color),
            SizedBox(width: AppDimensions.d7.w),
            Expanded(child: Text(message).regularText(color ?? AppColors.redColor, AppDimensions.d12.sp))
          ],
        ),
      ),
      messageColor: color ?? AppColors.redColor,
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.fromLTRB(AppDimensions.d20.w, 0.0, AppDimensions.d28.w, 0.0),
      padding: EdgeInsets.fromLTRB(AppDimensions.d13.w, AppDimensions.d8.h, AppDimensions.d12.w, AppDimensions.d8.h),
      // icon: ImageView(path: ImageConstants.errorInfoIcon),
      borderRadius: BorderRadius.circular(AppDimensions.d10.r),
      // forwardAnimationCurve: Curves.linear,
      // reverseAnimationCurve: Curves.linear,
      backgroundColor: bgColor ?? AppColors.errorRedColor,
      duration: const Duration(seconds: 3),
    );
    myFlushBar!.show(Get.context!);
  }

  static void dismissFlushBar() {
    if (myFlushBar != null) {
      myFlushBar!.dismiss();
    }
  }

  static final border = RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.d10.r));

  static Future showDialogWithTwoButtons(BuildContext context, String title, String content,
      {String positiveButtonLabel = "yes",
      VoidCallback? positiveButtonPress,
      String negativeButtonLabel = "cancel",
      VoidCallback? negativeButtonPress,
      barrierDismissible = true}) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title).boldText(AppColors.blackColor, AppDimensions.d14),
          content: Text(content).regularText(AppColors.blackColor, AppDimensions.d16),
          shape: border,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (negativeButtonPress != null) {
                  negativeButtonPress();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
              child: Text(negativeButtonLabel).mediumText(AppColors.blackColor, 18),
            ),
            TextButton(
              child: Text(positiveButtonLabel).mediumText(AppColors.blackColor, 18),
              onPressed: () {
                if (positiveButtonPress != null) {
                  positiveButtonPress();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
            )
          ],
        );
      },
    );
  }

  static Future showDialogWithButton(BuildContext context, String content, String title,
      {String positiveButtonLabel = "ok", VoidCallback? positiveButtonPress, barrierDismissible = true}) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          shape: border,
          actions: <Widget>[
            ElevatedButton(
              child: Text(positiveButtonLabel).mediumText(AppColors.blackColor, 18),
              onPressed: () {
                if (positiveButtonPress != null) {
                  positiveButtonPress();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
              style: ButtonStyle(
                  elevation: WidgetStateProperty.all(0),
                  backgroundColor: WidgetStateProperty.all(AppColors.whiteColor)),
            )
          ],
        );
      },
    );
  }
}