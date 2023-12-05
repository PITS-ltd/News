import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:news/core/constants/constant.dart';
import 'package:news/core/globals/globals.dart';
import 'package:news/data/api/news/news_api.dart';
import 'package:news/data/model/news.dart';
import 'package:news/domain/repositories/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitialState(PageState())) {
    on<NewsGet>((event, emit) async {
      emit(NewsLoadingState(state.pageState));
      NewsRepository newsRepository = NewsRepository();
      await newsRepository.getTopNews(AppConstants.token).then((value) async {
        if (value?.status.contains('ok') ?? false) {


          emit(NewsUp(
              state.pageState.copyWith( news: value)));

          if (value?.articles != null && value!.articles.isNotEmpty) {
            storeToLocal(value);
          }
        } else {
          emit(NewsLoadingState(state.pageState));

          News news = await getNewsFromStore();
          if (news.articles.isNotEmpty) {

            final SnackBar snackBar = SnackBar(content: Text('Последние загруженные новости'));
            snackbarKey.currentState?.showSnackBar(snackBar);
            emit(NewsUp(state.pageState.copyWith( news: news)));
          } else {
            emit(NewsError(state.pageState.copyWith(
              error: 'Ошибка загрузки новостей',
            )));
          }
        }
      });
    });

  }

  Future<void> storeToLocal(News news) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonNews = jsonEncode(news);
    sharedPreferences.setString('news', jsonNews);
  }

  Future<News> getNewsFromStore() async {
    SharedPreferences sharedNews = await SharedPreferences.getInstance();
    String newsFRomStore = sharedNews.getString('news') ?? '';
    News newsO = News.fromJson(jsonDecode(newsFRomStore));

    return (newsO != null) ? newsO : const News();
  }
}
