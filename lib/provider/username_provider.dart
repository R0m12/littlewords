import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final usernameProvider = FutureProvider<String?>((ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  const key = 'username';
  final String? username = prefs.getString(key);
  return username;
});