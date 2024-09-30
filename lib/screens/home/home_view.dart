// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, sized_box_for_whitespace, must_be_immutable, override_on_non_overriding_member, unnecessary_string_interpolations, avoid_unnecessary_containers, unused_import, non_constant_identifier_names, unnecessary_new, unused_field, unused_local_variable, unused_element, prefer_final_fields, unnecessary_null_comparison
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pixabay_demo/appstyle/app_colors.dart';
import 'package:pixabay_demo/appstyle/app_dimensions.dart';
import 'package:pixabay_demo/appstyle/app_extentions.dart';
import 'package:pixabay_demo/appstyle/app_spacing.dart';
import 'package:pixabay_demo/appstyle/text_box_decoration.dart';
import 'package:pixabay_demo/screens/home/home_controller.dart';
import 'package:pixabay_demo/widgets/format_helper.dart';

class HomeView extends StatelessWidget {
  var dsh = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
            appBar: _appBar(),
            body: Container(
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  _searchTextFormField(controller),
                  _imagesWidget(controller),
                ],
              ),
            )));
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: AppColors.whiteColor,
      automaticallyImplyLeading: false,
      title: Center(
          child: Text("pixabay_demo")
              .boldText(AppColors.blackColor, AppDimensions.d16)),
    );
  }

  Widget _searchTextFormField(HomeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.d10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.h10,
          SizedBox(
            width: double.infinity,
            height: AppDimensions.d60.h,
            child: TextFormField(
              controller: controller.searchController,
              decoration: ViewDecoration.inputDecorationWithCurve(
                  "Search", AppColors.whiteColor,
                  borderColor: AppColors.colorE0E0E0,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                        left: AppDimensions.d16.w, right: AppDimensions.d6.w),
                    child: Icon(
                      Icons.search,
                      color: AppColors.color828282,
                    ),
                  )),
              onChanged: (value) {
                if (value.trim().isEmpty) {
                } else {
                  controller.fetchImages();
                }
                controller.update();
              },
            ),
          ),
          AppSpacing.h10,
        ],
      ),
    );
  }

  Widget _imagesWidget(HomeController controller) {
    return controller.isLoading
        ? Center(child: CircularProgressIndicator())
        : Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.d10),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final crossAxisCount = (screenWidth / 180).floor();
                  return controller.imagesData.total == 0
                      ? Text("searched_category_not_found")
                          .regularText(AppColors.blackColor, AppDimensions.d14)
                      : GridView.builder(
                          controller: controller.scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 1,
                          ),
                          itemCount: controller.imagesData.hits!.length,
                          itemBuilder: (context, index) {
                            final image = controller.imagesData.hits![index];
                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ImageTile(
                                  imageUrl: image.webformatURL!,
                                  likes: image.likes!,
                                  views: image.views!,
                                ),
                                !kIsWeb &&
                                        (Platform.isAndroid || Platform.isIOS)
                                    ? IconButton(
                                        onPressed: () async {
                                          await controller.downloadImage(
                                              context, image.webformatURL!);
                                        },
                                        icon: Icon(
                                          Icons.download,
                                          color: AppColors.colorC5C6CC,
                                        ))
                                    : Container()
                              ],
                            );
                          },
                        );
                },
              ),
            ),
          );
  }
}

class ImageTile extends StatelessWidget {
  final String imageUrl;
  final int likes;
  final int views;

  const ImageTile({
    required this.imageUrl,
    required this.likes,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimensions.d4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up, size: AppDimensions.d16),
                    AppSpacing.w4,
                    Text('${FormatHelper.viewsAndLikesFormat(likes)}'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.visibility, size: AppDimensions.d16),
                    AppSpacing.w4,
                    Text('${FormatHelper.viewsAndLikesFormat(views)}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
