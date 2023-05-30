// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      status: json['status'] as String? ?? '',
      totalResults: json['totalResults'] as int?,
      articles: (json['articles'] as List<dynamic>?)
              ?.map((e) => Articles.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };

Articles _$ArticlesFromJson(Map<String, dynamic> json) => Articles(
      author: json['author'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      publishedAt: json['publishedAt'] as String? ?? '',
      content: json['content'] as String?,
      urlToImage: json['urlToImage'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ArticlesToJson(Articles instance) => <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
      'urlToImage': instance.urlToImage,
      'url': instance.url,
    };
