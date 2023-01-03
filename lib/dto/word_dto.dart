import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_dto.g.dart';
//test
@JsonSerializable()
class WordDTO{
  WordDTO(this.uid, this.author, this.content, this.latitude, this.longitude);

  final int uid;
  final String? author;
  final String? content;
  final double? latitude;
  final double? longitude;

  Map<String, dynamic> toJson() => _$WordDTOToJson(this);

  factory WordDTO.fromJson(Map<String, dynamic> json) => _$WordDTOFromJson(json);

  static fromResultSet(Map<String, dynamic> map) => WordDTO.fromJson(map);
//test
}