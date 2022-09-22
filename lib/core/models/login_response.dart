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

  @JsonKey(name: 'msg')
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


/*

{
    "success": true,
    "user_status": "new",
    "msg": "user created!",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODMzLCJpYXQiOjE2NjM4NTI2OTl9.G4DuQRVqlAFfCm-FqPWh76tSfoWBcLF4AidKHxgt6Cg"
}

{
    "success": true,
    "msg": "Token returning!",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2NjM4NTI3MTF9.4WYrtvtBYLkGbCSUjEqZ-J-yiJwq1BaRTC3v0OguEjE",
    "name": null,
    "mobile": "0512345670"
}

{
    "success": true,
    "msg": "Token returning!",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2NjM4NTI3MjB9.v8wsgJjlL2YLAkjc5UmgJDJVs2gqUQixtjcTSSt1WZA",
    "name": "Majed",
    "mobile": "0512345678"
}

*/