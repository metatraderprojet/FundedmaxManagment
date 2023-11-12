import 'dart:convert';

class GetMarketingEmailsResult {
  List<Result> result;

  GetMarketingEmailsResult({
    required this.result,
  });

  factory GetMarketingEmailsResult.fromRawJson(String str) => GetMarketingEmailsResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetMarketingEmailsResult.fromJson(Map<String, dynamic> json) => GetMarketingEmailsResult(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  String id;
  String emailAddress;

  Result({
    required this.id,
    required this.emailAddress,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    emailAddress: json["emailAddress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emailAddress": emailAddress,
  };
}
