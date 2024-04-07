import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/token_model.dart';
import '../../models/user_model.dart';

class UserNetwork {
  static const String url = "https://api.escuelajs.co/api/v1/auth";
  static Future<dynamic> login(String email, String password) async {
    Uri uri = Uri.parse('$url/login');

    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };
    var body = jsonEncode(<String, dynamic>{
      "email": email,
      "password": password,
    });

    final response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 201) {
      TokenModel tokenModel = TokenModel.fromJson(jsonDecode(response.body));
      return tokenModel;
    } else {
      return null;
    }
  }

  static Future<User> getUserWithSession(String? accessToken) async {
    Uri uri = Uri.parse('$url/profile');

    Map<String, String> headers = {"Authorization": "Bearer $accessToken"};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      throw Exception("error: ${response.statusCode}");
    }
  }
}
