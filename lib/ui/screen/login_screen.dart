import 'package:another_flushbar/flushbar.dart';
import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:ifinapp/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationActionCubit(
        authenticationService: context.read<AuthenticationService>(),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          body: BlocConsumer<AuthenticationActionCubit, BaseState<UserModel>>(
            listener: (context, actionState) {
              if (actionState is SuccessState) {
                // update data cubit
                context.read<AuthenticationDataCubit>().update(
                      userModel: actionState.data!,
                    );

                // set init user cubit
                context.read<UserCubit>().init(
                      user: actionState.data!,
                    );

                // go to landing
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteName.landingScreen,
                  (route) => false,
                );
              }
              if (actionState is ErrorState) {
                Flushbar(
                  message: (actionState as ErrorState).message ?? 'Login fail',
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                ).show(context);
              }
            },
            builder: (context, actionState) {
              return LoadingOverlay(
                isLoading: actionState is LoadingState,
                child: SafeArea(
                  child: Form(
                    key: formKey,
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                const SizedBox(height: 20),
                                Image.asset(
                                  AssetPath.illustrationLogin,
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        'Selamat Datang!',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          color: primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'Silahkan masuk untuk melanjutkan pembelajaran',
                                      ),
                                      const SizedBox(height: 20),
                                      TextFieldWidget(
                                        controller: emailController,
                                        inputType: TextInputType.emailAddress,
                                        hint: 'Email',
                                        validator: (val) {
                                          if (val?.isEmpty ?? true) {
                                            return 'field ini tidak boleh kosong';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFieldWidget(
                                        controller: passwordController,
                                        obscure: true,
                                        hint: 'Kata Sandi',
                                        validator: (val) {
                                          if (val?.isEmpty ?? true) {
                                            return 'field ini tidak boleh kosong';
                                          }
                                          if (val!.length < 6) {
                                            return 'kata sandi min. 6 karakter';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 28),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: PrimaryButton(
                                          onTap: () {
                                            if (formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              context
                                                  .read<
                                                      AuthenticationActionCubit>()
                                                  .login(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                  );
                                            }
                                          },
                                          text: 'Masuk',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Tidak memiliki akun?'),
                                const SizedBox(height: 4),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteName.registerScreen,
                                    );
                                  },
                                  child: const Text(
                                    'Buat Akun',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
