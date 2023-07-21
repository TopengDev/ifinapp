import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationDataCubit, BaseState<UserModel>>(
      listener: (context, state) {
        if (state is UnAuthenticationState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.loginScreen,
            (route) => false,
          );
        }
        if (state is AuthenticatedState) {
          // set init user cubit
          context.read<UserCubit>().init(
                user: state.data!,
              );

          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.landingScreen,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Image.asset(AssetPath.icLogo),
          ),
        ),
      ),
    );
  }
}
