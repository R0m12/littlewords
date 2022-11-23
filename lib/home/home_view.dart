import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/dio_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, final WidgetRef ref) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Consumer(builder: (context, ref, widget){
            return ref.watch(versionProvider).when(data: (version){
              return Text(version);
            }, error:(error, stack){
              return const Text('Impossible de récupérer la version du back');
            }, loading:(){
              return const CircularProgressIndicator();
            });
          }),

          ElevatedButton(
            onPressed: () async {
              final AsyncValue<String> value = ref.read(versionProvider);
              value.when(data: (data){
                print('response: $data');
              },
                  error: (objet, stack){
                    print(objet.toString());
                    print(stack.toString());
                  },
                  loading: (){
                    print('loading...');
              });
            },
            child: const Text('Get backend version'),
          ),
        ],

      ),
    );}
}
