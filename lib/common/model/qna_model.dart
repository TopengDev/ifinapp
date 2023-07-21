import 'package:equatable/equatable.dart';

class QnAModel extends Equatable {
  final String? question;
  final List<String>? answerChoices;
  final String? correctAnswer;

  const QnAModel({
    this.question,
    this.answerChoices,
    this.correctAnswer,
  });

  @override
  List<Object?> get props => [
        question,
        answerChoices,
        correctAnswer,
      ];
}
