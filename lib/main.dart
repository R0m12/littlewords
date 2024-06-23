import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/db/db_helper.dart';
import 'package:littlewords/dto/create_word.dart';
import 'package:littlewords/home/home_view.dart';
import 'package:littlewords/home/login_screen.dart';
import 'package:littlewords/home/liste_mots.dart';
import 'package:littlewords/provider/username_provider.dart';
import 'package:littlewords/routes/ErrorView.dart';
import 'package:littlewords/routes/LoadedView.dart';

import 'home/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialisation de la base de données
  DbHelper.init();
  // Lancement de l'application
  runApp(const ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isRoute(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/liste': (context) => const ListeMots(),
        '/create': (context) => const CreateWords(),
      },
    );
  }
}

//class MyHomePage extends StatefulWidget {
//  const MyHomePage({super.key, required this.title});
//  final String title;
//  @override
//  State<MyHomePage> createState() => _MyHomePageState();
//}

//class _MyHomePageState extends State<MyHomePage> {

class _isRoute extends ConsumerWidget {
  const _isRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(usernameProvider).when(data: _isData, error: _isError, loading: _isLoaded);
  }

  Widget _isData(String? username) {
    if (null == username) {
      return LoginScreen();
    }
    return const HomeView();
  }

  Widget _isError(Object erreur, StackTrace? stackTrace) {
    return const ErrorView();
  }

  Widget _isLoaded() {
    return const LoadedView();
  }
}
