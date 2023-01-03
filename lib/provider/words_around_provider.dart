import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/dio_provider.dart';
import 'package:littlewords/dto/word_dto.dart';
import 'package:littlewords/routes/device_Location.dart';

import '../dto/words_dto.dart';

final wordsAroundProvider = FutureProvider<List<WordDTO>>((ref) async {
  AsyncValue<LatLng?> location = ref.watch(deviceLocationProvider);
  return location.map(data: (data) async {
    print('try to get words around ${data.value!.latitude} ${data.value!
        .longitude}');

    final Dio dio = ref.read(dioProvider);
    Response response = await dio.get(
        '/word/around?latitude=${data.value!.latitude}&longitude=${data.value!
            .longitude}');
    var jsonAsString = response.toString();
    var json = jsonDecode(jsonAsString);

    final WordsDTO wordsDTO = WordsDTO.fromJson(json);
    if (wordsDTO.data == null) {
      return Future.value([]);
    }
    return Future.value(wordsDTO.data!);
  }, error: (error){
    print(error);
    return Future.value([]);
  }, loading: (loading){
    print('loading');
    return Future.value([]);
  });
});