import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@immutable
@JsonSerializable()
class User {
  const User({required this.name, required this.mobile});

  factory User.fromJson(Map<String, dynamic> jsonValue) =>
      _$UserFromJson(jsonValue);

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'mobile')
  final String mobile;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
