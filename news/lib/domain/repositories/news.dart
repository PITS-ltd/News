import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/core/globals/globals.dart';
import 'package:news/data/api/news/news_api.dart';
import 'package:news/data/model/news.dart';
import 'package:news/data/network/dio_exception.dart';

class NewsRepository {
  Future<News?> getTopNews(String token) async {
    try {
      final response = await NewsApi.getTopNews(token);
      return (response?.data != null)
          ? News.fromJson(response!.data)
          : const News();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      final SnackBar snackBar = SnackBar(content: Text(errorMessage));
      snackbarKey.currentState?.showSnackBar(snackBar);
      return const News();
    }
  }
}


