import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';

Future<User> register(Map<String, String> body) async {
  print('hereee register');
  final response = await http.post(
    Uri.parse('https://www.osamapro.online/api/register'),
    body: body,
  );
  print(jsonDecode(response.body));
  print('---------------------');
  // print(userFromJson(response.body));
  if (response.statusCode == 201) {
    print('success');
    return userFromJson(response.body);
  } else {
    throw Exception('Failed to register');
  }
}
