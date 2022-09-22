import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_u/core/config/settings.dart';

part 'account.g.dart';

@immutable
@JsonSerializable()
class Account {
  const Account({required this.token});

  factory Account.fromJson(Map<String, dynamic> jsonValue) =>
      _$AccountFromJson(jsonValue);

  static List<Account> fromJsonList(List<dynamic> jsonList) {
    final list = <Account>[];
    for (var item in jsonList) {
      list.add(Account.fromJson(item));
    }
    return list;
  }

  static const scheme = Settings.tokenScheme;

  @JsonKey(name: 'token')
  final String token;

  String get accessToken => '$scheme $accessToken';

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
