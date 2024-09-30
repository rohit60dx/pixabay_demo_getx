import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pixabay_demo/locator.dart';
import 'package:pixabay_demo/model/get_images_model.dart';
import 'package:pixabay_demo/services/api.dart';
import 'package:pixabay_demo/services/fetch_data_exception.dart';

class HomeController extends GetxController {
  Api api = locator<Api>();
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  GetImagesModel imagesData = GetImagesModel();
  bool isLoading = true;
  bool hasMoreData = true;
  int currentPage = 1;

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
      isLoading = false;
      update();
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchImages(isPageLoading: true);
    }
  }
}
