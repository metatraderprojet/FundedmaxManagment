import 'dart:convert';

class LoginResult {
  String data;

  LoginResult({
    required this.data,
  });

  factory LoginResult.fromRawJson(String str) => LoginResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}
