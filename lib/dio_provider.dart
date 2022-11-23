import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:littlewords/up.response.dart';

final dioProvider = Provider<Dio>((ref){
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://backend.smallwords.samyn.ovh',
    connectTimeout: 10000,
    receiveTimeout: 10000,

  ));
  return dio;

});

final versionProvider = FutureProvider<String>((ref) async {
  final Dio dio = ref.read(dioProvider);
  final Response response = await dio.get('/up');

 // On transforme la reponse en string
  final String jsonAsString = response.toString();
  // On transforme le string en Map<String, dynamic>
  final Map<String, dynamic> jsonDecoded = jsonDecode(jsonAsString);
  // On instancie UpResponse
  final UpResponse upResponse = UpResponse.fromJson(jsonDecoded);

  //on retourne un des atrributs de UpReponse
  return upResponse.version;
});