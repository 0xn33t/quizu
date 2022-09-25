import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_score.g.dart';

@immutable
@JsonSerializable()
class TopScore {
  const TopScore({required this.name, required this.score});

  factory TopScore.fromJson(Map<String, dynamic> jsonValue) =>
      _$TopScoreFromJson(jsonValue);

  static List<TopScore> fromJsonList(List<dynamic> jsonList) {
    final list = <TopScore>[];
    for (var item in jsonList) {
      list.add(TopScore.fromJson(item));
    }
    return list;
  }

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'score')
  final int score;

  Map<String, dynamic> toJson() => _$TopScoreToJson(this);
}
