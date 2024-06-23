import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/db/db_helper.dart';
import 'package:littlewords/dto/word_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dio_provider.dart';
import '../provider/device_location_provider.dart';

void main() {
  runApp(const CreateWords());
}

class CreateWords extends StatefulWidget {
  const CreateWords({Key? key}) : super(key: key);

  @override
  State<CreateWords> createState() => _MyCreateWordsState();
}

class _MyCreateWordsState extends State<CreateWords> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController ? wordsController;

  @override
  void initState() {
    super.initState();
    wordsController = TextEditingController();
    wordsController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Création d'un mot"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: wordsController,
                      scrollPadding: const EdgeInsets.all(20),
                      decoration: const InputDecoration(
                        hintText: 'Saisissez votre mot ici :',
                      ),
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                    _Enregistrer(wordsController: wordsController)
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

class _Enregistrer extends ConsumerWidget {
  const _Enregistrer({Key? key , required this.wordsController}) : super(key: key);

  final wordsController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(deviceLocationProvider).when(data: (data) => _whenData(context, data, ref), error: error, loading: loading);
  }

  Widget _whenData(context, data, ref){
    return ElevatedButton(
      onPressed: _isTextBlank() ? null : () => _createWord(ref, context, data),
          //_sendWordOnServer(ref, context, data),
      child: Text(_isTextBlank() ? 'Écrire un message' : 'Déposer un message'),
    );
  }

  Widget error(error, stackTrace) {
    return const Text('error');
  }

  Widget loading() {
    return const Text('loading');
  }

  _isTextBlank() {
    return wordsController!.text.trim().isEmpty;
  }

  _createWord(final WidgetRef ref, BuildContext context, LatLng data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    final String? author =  username;
    final String content = wordsController!.text;
    final double latitude = data.latitude;
    final double longitude = data.longitude;
    WordDTO motSaisi = WordDTO(null, author, content, latitude, longitude);
    DbHelper.insert(motSaisi);
    wordsController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Votre mot a bien été enregistré.'),
      ),
    );
  }

  _sendWordOnServer(final WidgetRef ref , BuildContext context, LatLng data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    final String? author =  username;
    final String content = wordsController!.text;
    final double latitude = data.latitude;
    final double longitude = data.longitude;
    var dio = ref.read(dioProvider);
    dio
        .post('/create', data: WordDTO(1, author, content, latitude, longitude))
        .then((value) => Navigator.of(context).pop());
  }
}
