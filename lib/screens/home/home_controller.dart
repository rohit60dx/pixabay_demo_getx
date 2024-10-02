import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixabay_demo/appstyle/app_colors.dart';
import 'package:pixabay_demo/locator.dart';
import 'package:pixabay_demo/model/get_images_model.dart';
import 'package:pixabay_demo/services/api.dart';
import 'package:pixabay_demo/services/fetch_data_exception.dart';
import 'package:pixabay_demo/widgets/dialoge_helper.dart';

class HomeController extends GetxController {
  Api api = locator<Api>();
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  GetImagesModel imagesData = GetImagesModel();
  bool isLoading = true;
  bool hasMoreData = true;
  int currentPage = 1;
  bool isInternetConnected = false;
  @override
  void onInit() {
    super.onInit();
    fetchImages();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  Future<void> fetchImages({bool isPageLoading = false}) async {
    if (!hasMoreData && isPageLoading) return;
    if (!isPageLoading) {
      currentPage = 1;
      imagesData = GetImagesModel();
    }
    try {
      isLoading = true;
      final model = await api.getImages(
          searchQuery: searchController.text, page: currentPage);
      if (model != null) {
        isInternetConnected = true;
        isLoading = false;
        if (isPageLoading) {
          imagesData.hits!.addAll(model.hits!);
        } else {
          imagesData = model;
        }
        hasMoreData = model.hits!.isNotEmpty;
        currentPage++;
        update();
      }
    } on FetchDataException catch (e) {
      isLoading = false;
      update();
    } on SocketException {
      isInternetConnected = false;
      isLoading = false;
      debugPrint("not internet");
      DialogHelper.message("No Internet!",
          bgColor: AppColors.redColor, color: AppColors.whiteColor);
      update();
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchImages(isPageLoading: true);
    }
  }

  Future<void> downloadImage(BuildContext context, String imageUrl) async {
    if (await _requestPermission(context)) {
      try {
        Directory? appDir = await getExternalStorageDirectory();
        String newPath = "";

        List<String> folders = appDir!.path.split("/");
        for (int i = 1; i < folders.length; i++) {
          String folder = folders[i];
          if (folder == "Android") break;
          newPath += "/" + folder;
        }
        newPath = newPath + "/YourAppName";
        appDir = Directory(newPath);

        if (!await appDir.exists()) {
          await appDir.create(recursive: true);
        }

        String fileName = imageUrl.split('/').last;
        String filePath = '${appDir.path}/$fileName';

        Dio dio = Dio();
        await dio.download(imageUrl, filePath);

        GallerySaver.saveImage(filePath).then((bool? success) {
          DialogHelper.message("Image saved to gallery!",
              bgColor: AppColors.green, color: AppColors.whiteColor);
        });
      } catch (e) {
        DialogHelper.message("Failed to download image",
            bgColor: AppColors.redColor, color: AppColors.whiteColor);
      }
    } else {
      DialogHelper.message("Permission denied!",
          bgColor: AppColors.redColor, color: AppColors.whiteColor);
    }
  }

  Future<bool> _requestPermission(BuildContext context) async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      status = await Permission.storage.request();
      print("hello 1");
    }
    if (status.isPermanentlyDenied) {
      DialogHelper.showDialogWithButton(Get.context!,
          "we_need_storage_access".tr, "storage_permission_denied".tr,
          barrierDismissible: true, positiveButtonPress: () async {
        Get.back();
        await openAppSettings();
      });
    }
    return status.isGranted;
  }
}
