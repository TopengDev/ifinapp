import 'dart:math';

import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:ifinapp/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningProgressScreen extends StatelessWidget {
  const LearningProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel user = context.read<UserCubit>().state.data!;
    final List<LearningModel> learningDone = LearningModel.learnings
        .where(
          (element) =>
              element.level! < user.level! ||
              (element.level! == user.level! &&
                  element.segment! <= user.segment!),
        )
        .toList();

    int randomLearning = Random().nextInt(learningDone.length);

    // filter material >32 char
    final List<String> materials = learningDone[randomLearning]
        .splitMaterial
        .where((element) => element.length > 32)
        .toList();

    int randomIndex = Random().nextInt(materials.length);

    String description =
        learningDone[randomLearning].splitMaterial[randomIndex];

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        children: [
          const Text(
            'Alur Pembelajaran',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 24),
          const CardAchievement(),
          const SizedBox(height: 24),
          const Text(
            'DESCRIPTION',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: primaryColor,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}
