import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:http/http.dart' as http;

import '../models/link.dart';

Future<List<Link>> AddNewLink(Map<String, String> body) async {
  print('hereeee');
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);

  if (response.statusCode == 200) {
    final data =
        jsonDecode(response.body)['link']['user']['links'] as List<dynamic>;
    // print('$data  data');

    return data.map((e) => Link.fromJson(e)).toList();
  }

  return Future.error('Somthing wrong');
}
