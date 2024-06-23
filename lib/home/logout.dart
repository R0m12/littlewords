import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/home/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/username_provider.dart';

class Logout extends ConsumerWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(onPressed: () {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('username', "");
        ref.refresh(usernameProvider);
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
    });
  }
}
