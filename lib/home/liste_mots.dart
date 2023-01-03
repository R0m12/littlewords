import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListeMots extends StatelessWidget {
  const ListeMots({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  IconButton(onPressed: (){
                    //TODO: Supprimer le mot de la base de données
                    print("SUPPRIME");
                  },
                    icon: Icon(Icons.delete_forever),

                  ),
                  IconButton(onPressed: (){
                    //TODO: Redéposer le mot sur la carte à l'emplacement de l'utilisateur
                    print("DEPOSE");
                  },
                    icon: Icon(Icons.undo),
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('Retour à la carte')),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}