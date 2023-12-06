import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'results')
  final List<Results> results;
  @JsonKey(name: 'last_updated')
  final DateTime? lastUpdated;

  const News({
    this.status = '',
    this.results = const [],
    this.lastUpdated,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

  News copyWith({
    String? status,
    List<Results>? results,

  }) {
    return News(
      status: status ?? this.status,
      results: results ?? this.results,
    );
  }
}

@JsonSerializable()
class Results {

  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'url')
  final String? url;


  const Results({
    this.title = '',
    this.url,

  });

  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

  Results copyWith({
    String? title,
    String? url,

  }) {
    return Results(
      title: title ?? this.title,

      url: url ?? this.url,
    );
  }
}
