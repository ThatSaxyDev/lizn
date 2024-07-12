import 'package:fpdart/fpdart.dart';
import 'package:lizn/core/failure/failure.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/features/auth/model/user_model.dart';
import 'package:lizn/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final AuthRemoteRepository _authRemoteRepository = AuthRemoteRepository();

  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    Either<AppFailure, UserModel> res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );

    final val = switch (res) {
      Left(value: AppFailure l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
      Right(value: UserModel r) => state = AsyncValue.data(r),
    };
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    Either<AppFailure, UserModel> res = await _authRemoteRepository.login(
      email: email,
      password: password,
    );

    final val = switch (res) {
      Left(value: AppFailure l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
      Right(value: UserModel r) => state = AsyncValue.data(r),
    };

    val.log();
  }
}
