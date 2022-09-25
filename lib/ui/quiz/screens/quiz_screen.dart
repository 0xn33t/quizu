import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/models/question.dart';
import 'package:quiz_u/core/repositories/quiz_repository.dart';
import 'package:quiz_u/core/states/quiz_state.dart';
import 'package:quiz_u/ui/common/widgets/extended_future_builder.dart';
import 'package:quiz_u/ui/quiz/widgets/questions_list.dart';
import 'package:quiz_u/ui/quiz/widgets/quiz_timer.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.quiz),
      ),
      body: ChangeNotifierProvider(
        create: (_) => QuizState(),
        child: ExtendedFutureBuilder<List<Question>>(
          future: QuizRepository().getQuestions(),
          builder: (context, result) {
            return Column(
              children: [
                const QuizTimer(),
                Expanded(child: QuestionsList(questions: result.sublist(0, 5))),
              ],
            );
          },
        ),
      ),
    );
  }
}
