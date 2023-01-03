import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/dto/word_dto.dart';

import '../provider/words_around_provider.dart';

class WordsAroundMarketLayer extends ConsumerWidget {
  const WordsAroundMarketLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(wordsAroundProvider)
        .when(data: _onData, error: _onError, loading: _onLoading);
  }

  Widget _onData(List<WordDTO> words){
    final List<Marker> markers = <Marker>[];
    for (final WordDTO w in words){
      var wordPosition = LatLng(w.latitude!, w.longitude!);
      markers.add(Marker(
        point : wordPosition,
        builder : (context) {
          return _WordMakerContent(w);
        }
      ));
    }
    return MarkerLayer(markers: markers);
  }

  GestureDetector _WordMakerContent(WordDTO w){
    return GestureDetector(
      onTap: ()=> print('tapped ${w.uid}'),
      child: const Icon(
        Icons.message,
        size: 32,
      ),
    );
  }
  Widget _onLoading(){
    return const Center(child: CircularProgressIndicator());
  }

  Widget _onError(error, stack){
    print(error);
    return Container(
      color: Colors.red.withOpacity(0.5),
    );
  }
}
