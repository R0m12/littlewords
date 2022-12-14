import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CreateWords());
}

class CreateWords extends StatefulWidget {
  const CreateWords({super.key});

  @override
  State<StatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CreateWords> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool error = false;

  @override
  Widget build(BuildContext context){
    return Form(key: _formKey, child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:   CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: TextFormField(decoration: const InputDecoration(
            hintText: 'Saisissez un mot.',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            fillColor: Colors.black,
            contentPadding: EdgeInsets.zero,
          ),
              textAlign: TextAlign.center,
              validator: (String? value){
                setState(() {
                  error = value == null || value.isEmpty;
                });
                return null;
              },
              style: const TextStyle(
                color: Colors.black,
              )
          ),
        ),
        error ? Center(child: Text('Veuillez choisir un mot'),) : SizedBox(),
        Center(
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 16.0), child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {

              }
            },
            child: const Text('Ajouter'),
          ),
          ),
        ),
      ],
    ),
    );
  }
}