import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class AppStorage {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> deleteAll() async{
    await _storage.deleteAll();
  }
}

class AppToken{
  static Future<String?> getToken() async {
    return await AppStorage.read("token");
  }
}