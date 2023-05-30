part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}


class NewsGet extends NewsEvent {
}

class NewsMakeAllReadEvent extends NewsEvent {
  NewsMakeAllReadEvent();
}class NewsMakeOneReadEvent extends NewsEvent {
  int index;
  NewsMakeOneReadEvent(this.index);
}

