import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context){
    return Form(key: _formKey, child: Column(
      crossAxisAlignment:   CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: TextFormField(decoration: const InputDecoration(
            hintText: 'Saisissez un nom.',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            fillColor: Colors.black,
            contentPadding: EdgeInsets.zero,
          ),
            textAlign: TextAlign.center,
            validator: (String? value){
              if(value == null || value.isEmpty){
                return "Veuillez choisir un nom.";
              }
              return null;
            },
            style: const TextStyle(
              color: Colors.black,
            )
          ),
        ),
        Center(
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 16.0), child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {

              }
            },
            child: const Text('Confirmer'),
          ),
          ),
        ),
      ],
    ),
    );
  }
}