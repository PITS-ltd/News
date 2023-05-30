import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'totalResults')
  final int? totalResults;
  @JsonKey(name: 'articles')
  final List<Articles> articles;

  const News({
    this.status = '',
    this.totalResults,
    this.articles = const [],
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

  News copyWith({
    String? status,
    int? totalResults,
    List<Articles>? articles,

  }) {
    return News(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }
}

@JsonSerializable()
class Articles {
  @JsonKey(name: 'author')
  final String author;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'publishedAt')
  final String publishedAt;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'urlToImage')
  final String? urlToImage;
  @JsonKey(name: 'url')
  final String? url;

  const Articles({
    this.author = '',
    this.title = '',
    this.description,
    this.publishedAt = '',
    this.content,
    this.urlToImage,
    this.url,

  });

  factory Articles.fromJson(Map<String, dynamic> json) => _$ArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesToJson(this);

  Articles copyWith({
    String? author,
    String? title,
    String? description,
    String? publishedAt,
    String? content,
    String? urlToImage,
    String? url,

  }) {
    return Articles(
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      urlToImage: urlToImage ?? this.urlToImage,
      url: url ?? this.url,
    );
  }
}
