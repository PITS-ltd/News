part of 'news_bloc.dart';

@immutable
abstract class NewsState {
  final PageState pageState;

  const NewsState(this.pageState);
}

class NewsInitialState extends NewsState {
  const NewsInitialState(PageState pageState) : super(pageState);
}

class NewsLoadingState extends NewsState {
  const NewsLoadingState(PageState pageState) : super(pageState);
}

class NewsUp extends NewsState {
  const NewsUp(PageState pageState) : super(pageState);
}

class NewsError extends NewsState {
  const NewsError(PageState pageState) : super(pageState);
}

class PageState {
  bool onAwait;
  String dateTime;
  String error;
  News? news;
  List<Results> results;
  List<Results> resultsTemp;
  List<bool> isRead;
  bool isOffline;

  PageState({
    this.onAwait = false,
    this.news,
    this.results = const [],
    this.resultsTemp = const [],
    this.dateTime = '',
    this.error = '',
    this.isOffline = false,
    this.isRead = const [],
  });

  PageState copyWith({
    bool? onAwait,
    bool? isOffline,
    String? dateTime,
    List<Results>? results,
    List<Results>? resultsTemp,
    News? news,
    News? newsTemp,
    String? error,
    List<bool>? isRead,
  }) {
    return PageState(
      onAwait: onAwait ?? this.onAwait,
      news: news ?? this.news,
      results: results ?? this.results,
      resultsTemp: resultsTemp ?? this.resultsTemp,
      isOffline: isOffline ?? this.isOffline,
      isRead: isRead ?? this.isRead,
      dateTime: dateTime ?? this.dateTime,
      error: error ?? this.error,
    );
  }
}
