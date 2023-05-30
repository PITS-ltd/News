import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news/core/constants/constant.dart';
import 'package:news/data/api/news/news_api.dart';
import 'package:news/data/model/news.dart';
import 'package:news/domain/repositories/news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitialState(PageState())) {

    on<NewsGet>((event, emit) async {
      emit(NewsLoadingState(state.pageState));
      NewsRepository newsRepository = NewsRepository();
      await newsRepository.getTopNews(AppConstants.token).then((value) {
        if(value?.status.contains('ok') ?? false){
          List<bool> isReadTemp = [...state.pageState.isRead];
          value?.articles.forEach((element) {
            isReadTemp.add(false);
          });
          emit(NewsUp(state.pageState.copyWith(
            isRead: isReadTemp,
            news: value
          )));

        }
        else{
          emit(NewsError(state.pageState.copyWith(
            error: 'Ошибка загрузки новостей'
          )));
        }
      });
    });

    on<NewsMakeAllReadEvent>((event, emit)  {
      List<bool> isReadTemp = [];
      for(int i = 0; i< state.pageState.isRead.length; i++){
        isReadTemp.add(true);
      }
      emit(NewsUp(state.pageState.copyWith(
        isRead: isReadTemp
      )));
    });
    on<NewsMakeOneReadEvent>((event, emit)  {
      List<bool> isReadTemp = [];
      isReadTemp.addAll(state.pageState.isRead);
      isReadTemp.removeAt(event.index);
      isReadTemp.insert(event.index, true);

      emit(NewsUp(state.pageState.copyWith(
          isRead: isReadTemp
      )));
    });
  }
}
