import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class UpdateUserRequest {
  @JsonKey(name: 'name')
  final String name;

  const UpdateUserRequest({required this.name});

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}
