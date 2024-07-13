import 'package:fpdart/fpdart.dart';
import 'package:lizn/core/failure/failure.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/features/auth/model/user_model.dart';
import 'package:lizn/features/auth/repositories/auth_local_repository.dart';
import 'package:lizn/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
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
      Right(value: UserModel r) => {
          state = AsyncValue.data(r),
        },
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
      Right(value: UserModel r) => _loginSuccess(r),
    };

    val!.log();
  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(token: user.token);
    return state = AsyncValue.data(user);
  }

  Future<UserModel?> getUserData() async {
    state = const AsyncValue.loading();
    final token = await _authLocalRepository.getToken();
    if (token != null) {
      final res = await _authRemoteRepository.getCurrentUser(token: token);

      final val = switch (res) {
        Left(value: AppFailure l) => state = AsyncValue.error(
            l.message,
            StackTrace.current,
          ),
        Right(value: UserModel r) => state = AsyncValue.data(r),
      };

      return val.value;
    }

    return null;
  }
}
