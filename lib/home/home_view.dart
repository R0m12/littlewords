import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/dio_provider.dart';
import 'package:littlewords/routes/map.dart';
import 'package:littlewords/dto/create_word.dart';

import 'login_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreateWords(),
        /*body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[

              //LoginScreen(),
            ],
          ),
        )*/
    );
  }
}
