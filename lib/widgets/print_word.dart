import 'package:flutter/material.dart';

import '../dto/word_dto.dart';

class PrintWord extends StatelessWidget {
  const PrintWord({Key? key, required this.word}) : super(key: key);
  final WordDTO word;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.tealAccent,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(word.author ?? "", style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14)),
                const Spacer(),
                Text(word.uid.toString(), style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14,)),
              ],
            ),
            const SizedBox(height: 10),
            Text(word.content ?? "", style: const TextStyle(fontSize: 18),),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
