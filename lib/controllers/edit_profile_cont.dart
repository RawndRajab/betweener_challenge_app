import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:http/http.dart' as http;

import '../models/link.dart';

Future<List<Link>> EditProfilee() async {
  print('hereeee');
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  print(response.statusCode);
  print(jsonDecode(response.body));

  if (response.statusCode == 200) {
    // final data =
    //     jsonDecode(response.body)['link']['user']['links'] as List<dynamic>;
    // print('$data  data');
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  return Future.error('Somthing wrong');
}
