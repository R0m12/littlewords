import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dto/word_dto.dart';
import '../provider/words_provider.dart';
import 'my_words.dart';


class ListeMots extends ConsumerWidget {
  const ListeMots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(WordsProvider)
        .when(data: _whenData, error: _whenError, loading: _whenLoading);
  }

  Widget _whenData(List<WordDTO> words) {
    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        return MyWords(monMot: words[index]);
      },
    );
  }

  Widget _whenError(Object error, StackTrace? stackTrace) {
    return const Text('Error');
  }

  Widget _whenLoading() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
