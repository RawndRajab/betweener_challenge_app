import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:http/http.dart' as http;

import '../models/link.dart';

Future<bool> UpdateLink(Map<String, String> body,id) async {
  // print('hereeee');
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.put(Uri.parse('https://www.osamapro.online/api/links/$id'),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);
  // print(response);
  // print(response.body);
  print(response.statusCode);

  if (response.statusCode == 200) {
    // ignore: avoid_print
    // print(response.statusCode);
    print('true');
    // final jsonData = json.decode(response.body);
    return true;
  } else {
    throw Exception('Failed to login');
  }
}
