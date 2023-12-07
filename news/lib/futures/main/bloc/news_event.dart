part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}


class NewsGet extends NewsEvent {
  int numberOfCat;
  NewsGet(this.numberOfCat);
}

class NewsSearchEvent extends NewsEvent {
  String value;
  NewsSearchEvent(this.value);
}


