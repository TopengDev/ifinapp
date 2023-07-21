import 'package:dartz/dartz.dart';
import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationActionCubit extends Cubit<BaseState<UserModel>> {
  final AuthenticationService authenticationService;

  AuthenticationActionCubit({
    required this.authenticationService,
  }) : super(const InitializedState());

  void login({
    required String email,
    required String password,
  }) async {
    emit(const LoadingState());

    // check user login
    Either<UserModel, String> result = await authenticationService.login(
      email: email,
      password: password,
    );

    BaseState<UserModel> resultState = result.fold(
      (l) => SuccessState(data: l),
      (r) => ErrorState(message: r),
    );

    emit(resultState);
  }

  void register({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    emit(const LoadingState());

    // check user login
    Either<String, String> result = await authenticationService.register(
      fullName: fullName,
      username: username,
      email: email,
      password: password,
    );

    BaseState<UserModel> resultState = result.fold(
      (l) => SuccessState(message: l),
      (r) => ErrorState(message: r),
    );

    emit(resultState);
  }

  void logout() async {
    emit(const LoadingState());

    await authenticationService.logout();

    emit(const SuccessState());
  }
}
