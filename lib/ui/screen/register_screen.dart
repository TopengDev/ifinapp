import 'package:another_flushbar/flushbar.dart';
import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:ifinapp/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                Navigator.pop(context);

                Flushbar(
                  message: 'Register success, please login',
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ).show(context);
              }
              if (actionState is ErrorState) {
                Flushbar(
                  message:
                      (actionState as ErrorState).message ?? 'Register fail',
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
                                Image.asset(
                                  AssetPath.illustrationRegister,
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        'Buat Akun',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          color: primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'Silahkan isi data dibawah untuk medaftarkan akunmu.',
                                      ),
                                      const SizedBox(height: 20),
                                      TextFieldWidget(
                                        controller: fullNameController,
                                        hint: 'Nama Lengkap',
                                        validator: (val) {
                                          if (val?.isEmpty ?? true) {
                                            return 'field ini tidak boleh kosong';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFieldWidget(
                                        controller: usernameController,
                                        hint: 'Username',
                                        validator: (val) {
                                          if (val?.isEmpty ?? true) {
                                            return 'field ini tidak boleh kosong';
                                          }
                                          return null;
                                        },
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
                                      const SizedBox(height: 20),
                                      TextFieldWidget(
                                        controller: confirmPasswordController,
                                        obscure: true,
                                        hint: 'Konfirmasi Sandi',
                                        validator: (val) {
                                          if (val?.isEmpty ?? true) {
                                            return 'field ini tidak boleh kosong';
                                          }
                                          if (val != passwordController.text) {
                                            return 'konfirmasi sandi tidak sesuai dengan kata sandi';
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
                                                  .register(
                                                    fullName:
                                                        fullNameController.text,
                                                    username:
                                                        usernameController.text,
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                  );
                                            }
                                          },
                                          text: 'Buat Akun',
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
                                const Text('Sudah memiliki akun?'),
                                const SizedBox(height: 4),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Masuk',
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
