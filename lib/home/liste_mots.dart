import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListeMots extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          //children: [

          //],
        ),

        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Fermer')),
      ],
    );
  }
}