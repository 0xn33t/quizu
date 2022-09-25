import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@immutable
@JsonSerializable()
class Country {
  const Country({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
  });

  factory Country.fromJson(Map<String, dynamic> jsonValue) =>
      _$CountryFromJson(jsonValue);

  static List<Country> fromJsonList(List<dynamic> jsonList) {
    final list = <Country>[];
    for (var item in jsonList) {
      list.add(Country.fromJson(item));
    }
    return list;
  }

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'flag')
  final String flag;

  @JsonKey(name: 'code')
  final String code;

  @JsonKey(name: 'dial_code')
  final String dialCode;

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
