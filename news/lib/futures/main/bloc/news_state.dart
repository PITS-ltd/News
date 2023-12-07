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
  int selectedCat;
  List<String> category;

  PageState({
    this.onAwait = false,
    this.news,
    this.results = const [],
    this.resultsTemp = const [],
    this.dateTime = '',
    this.error = '',
    this.isOffline = false,
    this.isRead = const [],
    this.selectedCat = 0,
    this.category = const ["arts", "automobiles", "books/review", "business", "fashion", "food", "health", "home", "insider", "magazine", "movies", "nyregion", "obituaries", "opinion", "politics", "realestate", "science", "sports", "sundayreview", "technology", "theater", "t-magazine", "travel", "upshot", "us", "world"],
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
    int? selectedCat,
    List<String>? category,
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
      selectedCat: selectedCat ?? this.selectedCat,
      category: category ?? this.category,
    );
  }
}
