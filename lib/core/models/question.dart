import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@immutable
@JsonSerializable()
class Question {
  const Question({
    required this.question,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.correct,
  });

  factory Question.fromJson(Map<String, dynamic> jsonValue) =>
      _$QuestionFromJson(jsonValue);

  static List<Question> fromJsonList(List<dynamic> jsonList) {
    final list = <Question>[];
    for (var item in jsonList) {
      list.add(Question.fromJson(item));
    }
    return list;
  }

  @JsonKey(name: 'Question')
  final String question;

  @JsonKey(name: 'a')
  final String a;

  @JsonKey(name: 'b')
  final String b;

  @JsonKey(name: 'c')
  final String c;

  @JsonKey(name: 'd')
  final String d;

  @JsonKey(name: 'correct')
  final String correct;

  Map<String, String> get _choicesMap => {'a': a, 'b': b, 'c': c, 'd': d};

  Iterable<MapEntry<String, String>> get choices => _choicesMap.entries;

  bool isCorrectAnswer(String choice) => choice == correct;

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
