import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dto/word_dto.dart';
import '../db/db_helper.dart';

final WordsProvider = FutureProvider<List<WordDTO>>((ref) async {
  final response = await DbHelper.getAllWords();

  for (var i = 0; i < response.length;) {
    if (response[i].uid == null) {
      return Future.value([]);
    }
    return Future.value(response);
  }
    return Future.value([]);
  }
);
