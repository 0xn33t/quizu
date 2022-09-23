import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_score.g.dart';

@immutable
@JsonSerializable()
class UserScore {
  const UserScore({required this.date, required this.score});

  factory UserScore.fromJson(Map<String, dynamic> jsonValue) =>
      _$UserScoreFromJson(jsonValue);

  static List<UserScore> fromJsonList(List<dynamic> jsonList) {
    final list = <UserScore>[];
    for (var item in jsonList) {
      list.add(UserScore.fromJson(item));
    }
    return list;
  }

  @JsonKey(name: 'date')
  final DateTime date;

  @JsonKey(name: 'score')
  final int score;

  Map<String, dynamic> toJson() => _$UserScoreToJson(this);
}
