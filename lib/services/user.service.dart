import 'dart:convert';
import 'package:chess_lib/models/user.model.dart';
import 'package:http/http.dart' as http;

class UserS{
  Future<dynamic> createUser(User user) async {

    final Map<String, String> _headers = {"content-type": "application/json"};
    final res = await http.post(Uri.parse("http://192.168.100.5:3000/saveNote"), headers: _headers, body: userToJson(user));
    if(res.body.isEmpty) return null;
    return json.decode(res.body);
  }
}