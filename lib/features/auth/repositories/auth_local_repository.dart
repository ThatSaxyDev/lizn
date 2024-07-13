import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  void setToken({required String? token}) {
    if (token != null) {
      token.log();
      _secureStorage.write(
        key: 'x-auth-token',
        value: token,
      );
    }
  }

  Future<String?> getToken() async {
    final res = await _secureStorage.read(key: 'x-auth-token');
    return res;
  }
}
