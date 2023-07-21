import 'package:dartz/dartz.dart';
import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationDataCubit extends Cubit<BaseState<UserModel>> {
  final AuthenticationService authenticationService;

  AuthenticationDataCubit({
    required this.authenticationService,
  }) : super(const InitializedState());

  void init() async {
    emit(const LoadingState());

    // check user login
    Either<UserModel?, String> result =
        await authenticationService.hasLoggedIn();

    BaseState<UserModel> resultState = result.fold(
      (l) => l != null
          ? AuthenticatedState(data: l)
          : const UnAuthenticationState(),
      (r) => ErrorState(message: r),
    );

    // delay 2s
    await Future.delayed(const Duration(seconds: 2));

    emit(resultState);
  }

  void update({UserModel? userModel}) {
    if (userModel != null) {
      emit(AuthenticatedState(data: userModel));
    } else {
      emit(const UnAuthenticationState());
    }
  }
}
