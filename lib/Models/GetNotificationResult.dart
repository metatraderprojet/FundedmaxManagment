import 'dart:convert';

class GetNotificationResult {
  List<Datum> data;

  GetNotificationResult({
    required this.data,
  });

  factory GetNotificationResult.fromRawJson(String str) => GetNotificationResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetNotificationResult.fromJson(Map<String, dynamic> json) => GetNotificationResult(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String header;
  String body;
  DateTime expireDate;
  int severity;
  String id;

  Datum({
    required this.header,
    required this.body,
    required this.expireDate,
    required this.severity,
    required this.id,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    header: json["header"],
    body: json["body"],
    expireDate: DateTime.parse(json["expireDate"]),
    severity: json["severity"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "header": header,
    "body": body,
    "expireDate": expireDate.toIso8601String(),
    "severity": severity,
    "id": id,
  };
}
