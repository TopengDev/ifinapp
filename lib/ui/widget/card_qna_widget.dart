import 'package:ifinapp/common/common.dart';
import 'package:flutter/material.dart';

class CardQnAWidget extends StatefulWidget {
  final QnAModel qna;
  final Function(bool) onAnswer;

  const CardQnAWidget({
    Key? key,
    required this.qna,
    required this.onAnswer,
  }) : super(key: key);

  @override
  State<CardQnAWidget> createState() => _CardQnAWidgetState();
}

class _CardQnAWidgetState extends State<CardQnAWidget> {
  String? selectedAnswer;
  int? indexAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16,
            right: 8,
            child: Image.asset(
              AssetPath.illustrationProfile,
              height: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.qna.question ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                ...List.generate(
                  widget.qna.answerChoices?.length ?? 0,
                  (index) {
                    String answer = widget.qna.answerChoices![index];
                    return Container(
                      margin: EdgeInsets.only(top: index == 0 ? 0 : 12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedAnswer = answer;
                            indexAnswer = index;
                          });
                          widget.onAnswer(
                            selectedAnswer == widget.qna.correctAnswer ||
                                widget.qna.correctAnswer!.isEmpty,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          child: Text(
                            answer,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: (indexAnswer == index &&
                                      selectedAnswer != null)
                                  ? selectedAnswer ==
                                              widget.qna.correctAnswer ||
                                          widget.qna.correctAnswer!.isEmpty
                                      ? Colors.green
                                      : Colors.red
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
