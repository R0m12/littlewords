// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordDTO _$WordDTOFromJson(Map<String, dynamic> json) => WordDTO(
      json['uid'] as int,
      json['author'] as String?,
      json['content'] as String?,
      json['latitude'] as double,
      json['longitude'] as double,
    );

Map<String, dynamic> _$WordDTOToJson(WordDTO instance) => <String, dynamic>{
      'uid': instance.uid,
      'author': instance.author,
      'content': instance.content,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
