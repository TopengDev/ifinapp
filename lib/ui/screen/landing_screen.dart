import 'package:another_flushbar/flushbar.dart';
import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:ifinapp/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

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
                // reset auth data & user
                context.read<AuthenticationDataCubit>().update(
                      userModel: null,
                    );

                context.read<UserCubit>().reInit();

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteName.loginScreen,
                  (route) => false,
                );

                Flushbar(
                  message: 'Logout success',
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ).show(context);
              }
              if (actionState is ErrorState) {
                Flushbar(
                  message: (actionState as ErrorState).message ?? 'Logout fail',
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                ).show(context);
              }
            },
            builder: (context, actionState) {
              return LoadingOverlay(
                isLoading: actionState is LoadedState,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: kToolbarHeight,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const UsernameWidget(),
                            InkWell(
                              onTap: () {
                                context
                                    .read<AuthenticationActionCubit>()
                                    .logout();
                              },
                              child: const Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 24,
                          ),
                          children: [
                            CardLandingWidget(
                              title: 'Mulai Belajar',
                              subtitle:
                                  'Memulai perjalanan pembelajaran baru atau melanjutkan pembelajaran sebelumnya',
                              image: AssetPath.illustrationStarStudy,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.learningScreen,
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            CardLandingWidget(
                              title: 'Progresi Pembelajaran',
                              subtitle:
                                  'Melihat progresi pembelajaran secara kesuluruhan',
                              image: AssetPath.illustrationLearningProgress,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.learningProgressScreen,
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            CardLandingWidget(
                              title: 'Leaderboard',
                              subtitle:
                                  'Melihat ranking dan membandingkan progresi dengan para pembelajar lainnya',
                              image: AssetPath.illustrationLeaderboard,
                              onTap: () {},
                            ),
                            const SizedBox(height: 12),
                            CardLandingWidget(
                              title: 'Profil',
                              subtitle: 'Lihat profil',
                              image: AssetPath.illustrationProfile,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
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
