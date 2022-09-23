import 'package:json_annotation/json_annotation.dart';

part 'record_score_request.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class RecordScoreRequest {
  @JsonKey(name: 'score')
  final String score;

  const RecordScoreRequest({required this.score});

  Map<String, dynamic> toJson() => _$RecordScoreRequestToJson(this);
}
