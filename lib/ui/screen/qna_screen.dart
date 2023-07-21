import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:ifinapp/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QnaScreen extends StatefulWidget {
  final LearningModel learning;

  const QnaScreen({
    Key? key,
    required this.learning,
  }) : super(key: key);

  @override
  State<QnaScreen> createState() => _QnaScreenState();
}

class _QnaScreenState extends State<QnaScreen> {
  final PageController pageController = PageController();
  final List<bool> correctAnswers = [];

  late List<Widget> children;

  @override
  void initState() {
    children = List.generate(
      widget.learning.qnaList?.length ?? 0,
      (index) {
        QnAModel qna = widget.learning.qnaList![index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardQnAWidget(
                  qna: qna,
                  onAnswer: (val) async {
                    correctAnswers.add(val);

                    if (index == widget.learning.qnaList!.length - 1) {
                      await Future.delayed(const Duration(seconds: 1));
                      // go to success screen
                      Future.delayed(const Duration(seconds: 1)).then(
                        (value) {
                          double result = correctAnswers
                                  .where((element) => element)
                                  .toList()
                                  .length /
                              widget.learning.qnaList!.length;

                          bool isCompleted = result >= 0.75;
                          if (isCompleted) {
                            // update user
                            context.read<UserCubit>().update();
                          }

                          return Navigator.pushNamed(
                            context,
                            isCompleted
                                ? RouteName.successScreen
                                : RouteName.failScreen,
                          );
                        },
                      );
                    } else {
                      await Future.delayed(const Duration(seconds: 1));
                      pageController.animateToPage(
                        (pageController.page ?? 0).toInt() + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: kToolbarHeight,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: UsernameWidget(),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
