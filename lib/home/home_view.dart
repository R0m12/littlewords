import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littlewords/home/liste_mots.dart';
import '../dto/create_word.dart';
import 'logout.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int bottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {

    final bodyPage = <Widget>[
     const CreateWords(),
      const ListeMots(),
      const Logout(),
    ];

    return Scaffold(
      body: bodyPage[bottomNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationIndex,
        onTap: (int index) {
          setState(() {
            bottomNavigationIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Créer un mot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Liste des mots',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.logout_rounded),
            label: 'Deconnexion',
          )
        ],
      ),
    );
  }
}
