import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_u/core/utils/validators.dart';

part 'login_response.g.dart';

@immutable
@JsonSerializable()
class LoginResponse {
  const LoginResponse({
    required this.success,
    required this.msg,
    required this.token,
    this.userStatus,
    this.name,
    this.mobile,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> jsonValue) =>
      _$LoginResponseFromJson(jsonValue);

  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String msg;

  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'user_status')
  final String? userStatus;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'mobile')
  final String? mobile;

  bool get isNewUser => userStatus?.toLowerCase() == 'new';

  bool get isNameSet => !Validators.isEmpty(name);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
