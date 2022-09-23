import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class LoginRequest {
  @JsonKey(name: 'OTP')
  final String otp;

  @JsonKey(name: 'mobile')
  final String mobile;

  const LoginRequest({required this.otp, required this.mobile});

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
