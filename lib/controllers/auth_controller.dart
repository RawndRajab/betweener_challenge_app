import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';

Future<User> login(Map<String, String> body) async {
  print('hereee login');
  final response = await http.post(
    Uri.parse(loginUrl),
    body: body,
  );
// print(jsonDecode(response.body));
// print('---------------------');
  // print(userFromJson(response.body));
  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception('Failed to login');
  }
}
