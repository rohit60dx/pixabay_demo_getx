// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_demo/appstyle/app_colors.dart';
import 'package:pixabay_demo/appstyle/app_dimensions.dart';
import 'package:pixabay_demo/appstyle/app_extentions.dart';
import 'package:pixabay_demo/screens/splash/splash_controller.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  var dsh = Get.isRegistered<SplashController>()
      ? Get.find<SplashController>()
      : Get.put(SplashController());

  @override
  Widget build(BuildContext context) => GetBuilder<SplashController>(
      builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text("pixabay").regularText(
                          AppColors.blackColor, AppDimensions.d20)),
                ],
              ),
            ],
          )));
}
