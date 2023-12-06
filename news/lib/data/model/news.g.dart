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
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'status': instance.status,
      'results': instance.results,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      title: json['title'] as String? ?? '',
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
    };
