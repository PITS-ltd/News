import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news/core/constants/constant.dart';

class NewsApi {
  static Future<Response?> getTopNews(String token, String category) async {
    var dio = Dio();
    Response? news;
    try {
      news = await dio.get('${AppConstants.base}/svc/topstories/v2/$category.json',
          queryParameters: {"api-key": token});

      print('STATUS ${news.statusMessage}');
      print('DATA ${news.data}');
      return news;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
