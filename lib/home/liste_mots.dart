import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:littlewords/db/db_helper.dart';
import 'package:littlewords/dto/word_dto.dart';

class ListeMots extends StatelessWidget {
  const ListeMots({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<WordDTO>> listeDeMesMots = DbHelper.instance.getAllWords();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo-no-background.png', height: 60),
      ),
      backgroundColor: Colors.cyanAccent[100],
      body: Center(
        child: (
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  //for (var unDeMesMots in listeDeMesMots) {
                    IconButton(onPressed: () {
                      //TODO: Supprimer le mot de la base de données
                      //DbHelper.instance.delete(unDeMesMots);
                      print("MOT SUPPRIME");
                    },
                      icon: Icon(Icons.delete_forever),

                    ),
                    IconButton(onPressed: () {
                      //TODO: Redéposer le mot sur la carte à l'emplacement de l'utilisateur
                      print("MOT DEPOSE");
                    },
                      icon: Icon(Icons.undo),
                    ),
                  //};
                ],
              ),
              //Bouton permettant de revenir à la map
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Retour à la carte')),
            ],
          )
        ),
      ),
    );
  }
}