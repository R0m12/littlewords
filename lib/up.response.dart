import 'package:freezed_annotation/freezed_annotation.dart';

part 'up.response.g.dart';

@JsonSerializable()
class UpResponse{
  // Constructeur
  UpResponse(this.version);

  // Attributs de class correspondantà la structure de notre JSON.
  final String version;

  //Factory JSON -> UpRsponse : dont le code est généré dans 'part'.
  factory UpResponse.fromJson(Map<String, dynamic> json)=>
      _$UpResponseFromJson(json); //Nom normé -> Pas le choix
}