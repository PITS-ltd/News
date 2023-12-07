// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      status: json['status'] as String? ?? '',
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastUpdated: json['last_updated'] == null
          ? null
          : DateTime.parse(json['last_updated'] as String),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'status': instance.status,
      'results': instance.results,
      'last_updated': instance.lastUpdated?.toIso8601String(),
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      title: json['title'] as String? ?? '',
      url: json['url'] as String?,
      multimedia: (json['multimedia'] as List<dynamic>?)
              ?.map((e) => Multimedia.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'multimedia': instance.multimedia,
    };

Multimedia _$MultimediaFromJson(Map<String, dynamic> json) => Multimedia(
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$MultimediaToJson(Multimedia instance) =>
    <String, dynamic>{
      'url': instance.url,
    };
