import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../db/db_helper.dart';
import '../dio_provider.dart';
import '../dto/word_dto.dart';
import '../provider/words_provider.dart';
import '../widgets/print_word.dart';

class MyWords extends ConsumerWidget {
  const MyWords({Key? key, required this.monMot}) : super(key: key);

  final WordDTO monMot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.refresh(WordsProvider);
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                  title: Text("Liste de mes mots")
              ),
              body: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: Text('Mot supprimé avec succès'),
                    tileColor: Colors.greenAccent,
                    onTap: () {
                      // Supprime le mot de la base de données locale
                      DbHelper.delete(monMot.uid.toString());
                      Navigator.of(context).pop();
                      ref.refresh(WordsProvider);
                    },
                  ),
                  _Btn(monMot: monMot)
                ],
              ),
            );
          },
        );
      },
      child: PrintWord(word: monMot),
    );
  }
}

class _Btn extends ConsumerWidget {
  const _Btn({Key? key , required this.monMot}) : super(key: key);
  final monMot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
     appBar: AppBar(title: Text("Liste de mes mots"),
     ),
      body: FutureBuilder(
          future: DbHelper.getAllWords(),
          builder: (context, snapshot){
            if (!snapshot.hasData){
              return const CircularProgressIndicator();
            }

            final List<WordDTO>? data = snapshot.data;
            if(data == null){
              return const Text('Aucun mot trouvé.');
            }
            // On retourne une Liste de WordDTO
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
                  WordDTO word = data[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PrintWord(word: word),
                  );
                }
            );
          }
        ),
    );
      //ref.watch(deviceLocationProvider).when(data: (data) => _isData(context, data, ref), error: error, loading: loading);
  }

  Widget _isData(context, data, ref){
    return ListTile(
      leading: const Icon(Icons.send),
      title: const Text('Envoyer au serveur'),
      onTap: () {
        try {
          _sendWordOnServer(ref, context, data);
          DbHelper.delete(monMot);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mot envoyé avec succès!'),
            ),
          );
          Navigator.of(context).pop();
          ref.refresh(WordsProvider);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erreur lors de l\'envoi du mot!'),
            ),
          );
        }
      },
    );
  }

  Widget error(error, stackTrace) {
    print(error.toString());
    return const Text('error');
  }

  Widget loading() {
    print('loading');
    return const Text('loading');
  }

  _sendWordOnServer(final WidgetRef ref , BuildContext context, LatLng data) async {
    final int uid = monMot.uid;
    final String? author =  monMot.author;
    final String content = monMot.content;
    final double latitude = data.latitude;
    final double longitude = data.longitude;
    print("uid" + uid.toString() + "author" + author.toString() + "content" + content + "latitude" + latitude.toString() + "longitude" + longitude.toString());
    try{
      final dio = ref.read(dioProvider);
      await dio.put('/word/$uid', data:WordDTO(uid, author, content, latitude, longitude));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
  }
}
