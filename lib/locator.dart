import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pixabay_demo/services/api.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => Api());
 
  locator.registerLazySingleton<Dio>(() {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      request: true,
      requestHeader: false,
      responseHeader: true,
    ));
    return dio;
  });
}