import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/username_provider.dart';

void main() {
  runApp(const LoginScreen());
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool textFieldError = false;
  TextEditingController loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children  :  [
            const Spacer(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 16),
              child: TextField(
                controller: loginController,
                decoration: const InputDecoration(
                    fillColor: Colors.red,
                    filled: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
              child :SaveUsernameButton(
                controller: loginController,
              ),
            )
          ]),
    );
  }
}

class SaveUsernameButton extends ConsumerWidget {
  const SaveUsernameButton({Key? key,required this.controller }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => _onPressed(ref),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
      ),
      child: const Text('Saisissez votre nom pour poursuivre !'),
    );
  }

  void _onPressed(WidgetRef ref){
    var text = controller.text;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('username', text);
      ref.refresh(usernameProvider);
    });
  }
}
