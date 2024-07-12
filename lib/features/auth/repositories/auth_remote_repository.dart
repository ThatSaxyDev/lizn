import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lizn/core/utils/extensions.dart';

class AuthRemoteRepository {
  //! sign up user
  Future<void> signup(
      {required String name,
      required String email,
      required String password}) async {
    final res = await http.post(
      Uri.parse('http://127.0.0.1:8000/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    res.body.log();
  }

  //! login
  Future<void> login() async {}
}
