import 'dart:async';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      await newsRepository
          .getTopNews(
              AppConstants.token, state.pageState.category[event.numberOfCat])
          .then((value) async {
        if (value?.status.contains('OK') ?? false) {
          getPush(value?.lastUpdated);

          getLastUpdate(value?.lastUpdated);

          if (value?.results != null && value!.results.isNotEmpty) {
            storeToLocal(value);
            emit(NewsUp(state.pageState.copyWith(
                news: value,
                results: value.results,
                resultsTemp: value.results, selectedCat: event.numberOfCat)));
            print(event.numberOfCat);
          }
        } else {
          emit(NewsLoadingState(state.pageState));

          News news = await getNewsFromStore();
          if (news.results.isNotEmpty) {
            final SnackBar snackBar =
                SnackBar(content: Text('Последние загруженные новости'));
            snackbarKey.currentState?.showSnackBar(snackBar);
            getLastUpdate(news.lastUpdated);
            emit(NewsUp(state.pageState.copyWith(
                news: news,
                results: news.results,
                resultsTemp: news.results,
                isOffline: true)));
          } else {
            emit(NewsError(state.pageState.copyWith(
              error: 'Ошибка загрузки новостей',
            )));
          }
        }
      });
    });

    on<NewsSearchEvent>((event, emit) async {
      List<Results> search = [];

      if (event.value.isNotEmpty) {
        for (var element in state.pageState.resultsTemp) {
          if (element.title.toLowerCase().contains(event.value.toLowerCase())) {
            search.add(element);
          }
          emit(NewsUp(state.pageState.copyWith(results: search)));
        }
      } else {
        emit(NewsUp(
            state.pageState.copyWith(results: state.pageState.resultsTemp)));
      }
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

  getLastUpdate(DateTime? lastUpdated) {
    String lastUpdate;
    if (lastUpdated != null) {
      lastUpdate = DateFormat('kk:mm EEE d MMM').format(lastUpdated);
    } else {
      lastUpdate = '';
    }
    emit(NewsUp(state.pageState.copyWith(dateTime: lastUpdate)));
  }

  Future<void> getPush(DateTime? lastUpdated) async {
    News newsFromStore = await getNewsFromStore();

    if (lastUpdated != null && newsFromStore.lastUpdated != null) {
      if (lastUpdated.isAfter(newsFromStore.lastUpdated!)) {
        String lastDateFromAPI =
            DateFormat('kk:mm EEE d MMM').format(lastUpdated);

        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: '${Emojis.plant_cactus} NEWS AVALIBLE!!!',
            body: 'News update at $lastDateFromAPI',
            notificationLayout: NotificationLayout.Default,
          ),
        );
      }
    }
    print(lastUpdated.toString());
    print(newsFromStore.lastUpdated.toString());
  }
}
