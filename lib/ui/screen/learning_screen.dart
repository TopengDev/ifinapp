import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:ifinapp/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({Key? key}) : super(key: key);

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final PageController pageController = PageController();

  late List<Widget> children;

  @override
  void initState() {
    final UserModel user = context.read<UserCubit>().state.data!;
    final bool isGraduate = user.level! > 9;
    final LearningModel learning = isGraduate
        ? LearningModel.learnings.last
        : LearningModel.learnings.firstWhere(
            (element) =>
                element.level == user.level && element.segment == user.segment,
          );

    children = List.generate(
      learning.splitMaterial.length,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardLearningWidget(
                title: learning.title ?? '',
                description: learning.splitMaterial[index],
              ),
              if (index == learning.splitMaterial.length - 1) ...[
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryButton(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteName.qnaScreen,
                        arguments: learning,
                      );
                    },
                    text: 'Start Practice',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: kToolbarHeight,
              child: const Align(
                alignment: Alignment.centerRight,
                child: UsernameWidget(),
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
