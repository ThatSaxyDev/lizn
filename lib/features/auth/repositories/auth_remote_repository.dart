import 'dart:convert';

// import 'package:fpdart/fpdart.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:lizn/core/constants/server_constants.dart';
import 'package:lizn/core/failure/failure.dart';
import 'package:lizn/core/typedefs/type_defs.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/features/auth/model/user_model.dart';

class AuthRemoteRepository {
  //! sign up user
  FutureEither<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstants.serverUrl}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode != 201) {
        return Left(AppFailure(message: resBodyMap['message']));
      }

      UserModel user = UserModel.fromMap(resBodyMap['data']);

      return Right(user);
    } catch (e) {
      e.log();
      return Left(AppFailure(message: e.toString()));
    }
  }

  //! login
  FutureEither<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstants.serverUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode != 200) {
        return Left(AppFailure(message: resBodyMap['message']));
      }

      UserModel user = UserModel.fromMap(resBodyMap['data']);

      return Right(user);
    } catch (e) {
      e.log();
      return Left(AppFailure(message: e.toString()));
    }
  }
}
