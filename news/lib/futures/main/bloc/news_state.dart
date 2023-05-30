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
  String error;
  News? news;
  List<bool> isRead;

  PageState({
    this.onAwait = false,
    this.news,
    this.error = '',
    this.isRead = const [],
  });

  PageState copyWith({
    bool? onAwait,
    News? news,
    String? error,
    List<bool>? isRead,
  }) {
    return PageState(
      onAwait: onAwait ?? this.onAwait,
      news: news ?? this.news,
      isRead: isRead ?? this.isRead,
      error: error ?? this.error,
    );
  }
}
