// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pixabay_demo/constants/api_constants.dart';
import 'package:pixabay_demo/locator.dart';
import 'package:pixabay_demo/model/get_images_model.dart';
import 'package:pixabay_demo/model/response_model.dart';
import 'package:pixabay_demo/services/fetch_data_exception.dart';

class Api {
  Dio dio = locator<Dio>();

  Future<GetImagesModel> getImages({
    String searchQuery = '',
    required int page,
  }) async {
    try {
      String url =
          "${ApiConstants.baseUrl}${ApiConstants.apiKey}&image_type=photo&pretty=true";

      if (searchQuery.isNotEmpty) {
        url += '&q=$searchQuery';
      }
      final response = await dio.get(
        url,
        queryParameters: {
          'page': page,
        },
      );
      return GetImagesModel.fromJson(json.decode(response.toString()));
    } on DioException catch (e) {
      throw throwException(e);
    }
  }

  Exception throwException(DioException e) {
    if (e.response != null) {
      ResponseModel? errorModel;
      try {
        errorModel = ResponseModel.fromJson(e.response!.data);
      } catch (e) {
        errorModel = ResponseModel.fromJson({
          "response": {"success": false, "message": "error"}
        });
      }
      throw FetchDataException(errorModel.response!.message);
    } else {
      if (e.type == DioExceptionType.cancel) {
        throw const SocketException("cencel");
      } else {
        throw const SocketException("");
      }
    }
  }
}
