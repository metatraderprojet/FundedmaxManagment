import 'package:fundedmax_managment/Services/StaticServices.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

import '../Models/GetMarketingEmailsResult.dart';
import '../Models/GetNotificationResult.dart';
class RestService{
  static String baseUrl = "https://fundedmax.org:5001/api/v1";
  static Future<String> Login(String username, String password) async {
    final Uri uri = Uri.parse('$baseUrl/Authentication/Login');

    try {
      final response = await http.get(
        uri.replace(queryParameters: {
          'login': username,
          'password': password,
        }),
        headers: {'accept': '*/*'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResult = json.decode(response.body);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(jsonResult['data']);
        if (! decodedToken.containsValue('admin') ){
          throw Exception("no admin rights");
        }
        return jsonResult['data'];
      } else{
        throw Exception(response.statusCode);
      }
    } catch (e) {
       rethrow;
    }
  }
  static Future<GetNotificationResult> GetNotifications() async {
    final String url =   '$baseUrl/User/GetNotifications';

    final Map<String, String> headers = {
      'accept': '*/*',
      'Authorization':
      'Bearer ${await AppToken.getToken()}',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return GetNotificationResult.fromRawJson(response.body);
      } else {
        throw Exception("bad result");
      }
    } catch (e) {
      rethrow;
    }
  }
  static Future<bool> DeleteNotification(String notificationId) async {
    final Uri uri = Uri.parse( '$baseUrl/admin/Admin/DeleteNotification?notificationId=$notificationId');

    try {
      final response = await http.delete(
        uri,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${(await AppToken.getToken())!}',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
       return false;
      }
    } catch (error) {
      return false;
    }
  }
  static Future<bool> addNotification({
    required String header,
    required String body,
    required DateTime expireDate,
    required int severity,
  }) async {
    final String apiUrl = '$baseUrl/admin/Admin/AddNotification';

    final Map<String, dynamic> data = {
      'header': header,
      'body': body,
      'expireDate': expireDate.toUtc().toIso8601String(),
      'severity': severity,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${(await AppToken.getToken())!}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      var r = response.body;
      if (response.statusCode == 200) {

        return true;
      } else {
       return false;
      }
    } catch (error) {
     return false;
    }
  }
  static Future<GetMarketingEmailsResult> GetMassMarketingEmails() async {
    final String apiUrl =  '$baseUrl/admin/Admin/GetMassMarketingEmails';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${(await AppToken.getToken())!}' ,
        },
      );

      if (response.statusCode == 200) {
        return GetMarketingEmailsResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load marketing emails. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
  static Future<bool> DeleteMassMarketEmail(String emailId) async {
    String url = '$baseUrl/admin/Admin/RemoveMassMarketingEmail';
    String token =
        'Bearer ${(await AppToken.getToken())!}';

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'accept': '*/*',
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(emailId),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  static Future<bool> AddMassMarketingEmail(String emailAddress) async {
    String url = '$baseUrl/admin/Admin/AddMassMarketingEmail';
    String token =
        'Bearer ${(await AppToken.getToken())!}';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'accept': '*/*',
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(emailAddress),
      );

      if (response.statusCode == 200) {
       return true;
      } else {
       return false;
      }
    } catch (e) {
     return false;
    }
  }



}