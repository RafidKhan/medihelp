import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:medihelp/utils/common_methods.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<Response?> getRequest({
    required String url,
  }) async {
    try {
      _dio.options.headers['X-RapidAPI-Key'] =
          '5e12cee4bbmsh79b21a20d7d8545p122cb5jsn09bab99b1176';
      _dio.options.headers['X-RapidAPI-Host'] =
          'drug-info-and-price-history.p.rapidapi.com';
      final Response? response = await _dio.get(url);
      if (response != null) {
        if (response.statusCode == 200) {
          return response;
        } else {
          snackBarWidget(title: "No data found", subTitle: "");
        }
      } else {
        snackBarWidget(title: "No data found", subTitle: "");
      }
    } on DioError catch (e) {
      snackBarWidget(title: "No data found", subTitle: "");
    } catch (e) {
      snackBarWidget(title: "No data found", subTitle: "");
    }
  }
}
