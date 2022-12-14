import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/routes/map.dart';

import 'login_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, "/liste");
              },
              tooltip: 'Liste des mots',
              child: const Icon(Icons.list_alt),
            );
          })
        ],
      ),
      body: LittleWordsMap(),
    );
  }
}
