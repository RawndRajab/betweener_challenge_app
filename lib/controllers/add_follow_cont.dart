import '../models/search.dart';
import '../models/user.dart' as userModel;
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<bool>? AddFollow(Map<String,String?> body) async {
  print('AddFollow------------');
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  userModel.User user = userModel.userFromJson(prefs.getString('user')!);
  // try {
  final response = await http.post(
    Uri.parse('https://www.osamapro.online/api/follow'),
    body: body,
    headers: {'Authorization': 'Bearer ${user.token}'},
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    print('statuse code=200');
    final Map<String, dynamic> data = json.decode(response.body);
    return true;
  } else {
    print('Search failed with status code: ${response.statusCode}');
    throw Exception('Failed to load users: ${response.body}');
  }
 
}
