import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardAchievement extends StatelessWidget {
  const CardAchievement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, BaseState<UserModel>>(
      builder: (context, state) {
        final UserModel user = state.data!;
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: primaryColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Pencapaian',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Current Level: ${(user.level! > 9 ? 9 : user.level!)}',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 24),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 4,
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      icEgg(
                        index: index + 1,
                        level: user.level ?? 1,
                        segment: user.segment ?? 1,
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Level ${index + 1}',
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  String icEgg({
    required int index,
    required int level,
    required int segment,
  }) {
    // white
    if (index <= 3) {
      if (level > index) {
        return AssetPath.icEggWhiteBroke;
      }
      if (level == index && segment == 2) {
        return AssetPath.icEggWhiteCrack;
      }
      return AssetPath.icEggWhite;
    }
    // brown
    else if (index <= 6) {
      if (level > index) {
        return AssetPath.icEggBrownBroke;
      }
      if (level == index && segment == 2) {
        return AssetPath.icEggBrownCrack;
      }
      return AssetPath.icEggBrown;
    }
    // gold
    else {
      if (level > index) {
        return AssetPath.icEggGoldBroke;
      }
      if (level == index && segment == 2) {
        return AssetPath.icEggGoldCrack;
      }
      return AssetPath.icEggGold;
    }
  }
}
