import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/follower.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';
import 'package:http/http.dart' as http;

Future<Followings> getFollow(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  print('${response.statusCode} ');
  if (response.statusCode == 200) {
    final data = followingsFromJson(response.body);

    return data;
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}
