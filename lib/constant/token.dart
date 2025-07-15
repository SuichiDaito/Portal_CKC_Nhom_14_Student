import 'package:shared_preferences/shared_preferences.dart';

class ConstraintToken {
  static Future<void> setToken(String token) async {
    final SharedPreferences _value = await SharedPreferences.getInstance();
    await _value.setString('token', token);
  }

  static Future<String> getToken() async {
    final SharedPreferences _value = await SharedPreferences.getInstance();
    return _value.getString('token') ?? "";
  }

  static Future<void> setPassword(String value) async {
    final SharedPreferences _value = await SharedPreferences.getInstance();
    await _value.setString('password', value);
  }
  
  static Future<String> getPassword() async {
    final SharedPreferences _value = await SharedPreferences.getInstance();
    return _value.getString('password') ?? "";
  }

  static Future<void> setIdSpecialized1(String value) async {
    final SharedPreferences _value = await SharedPreferences.getInstance();
    await _value.setString('id_chuyen_nganh1', value);
  }

  static Future<void> setIdSpecialized2(String value) async {
    final SharedPreferences _value = await SharedPreferences.getInstance();
    await _value.setString('id_chuyen_nganh2', value);
  }

  static Future<String> getIdSpecialized1() async {
    final SharedPreferences _value = await SharedPreferences.getInstance();
    return _value.getString('id_chuyen_nganh1') ?? '';
  }

  static Future<String> getIdSpecialized2() async {
    final SharedPreferences _value = await SharedPreferences.getInstance();
    return _value.getString('id_chuyen_nganh2') ?? '';
  }
}
