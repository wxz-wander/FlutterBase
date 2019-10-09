import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

///shared_preferences工具类
///todo 暂时未做sp分组存储，后期留作扩展
class SPUtil {
  static set(String key, dynamic value) async {
    var sp = await SharedPreferences.getInstance();
    if (value is String) {
      sp.setString(key, value);
    } else if (value is int) {
      sp.setInt(key, value);
    } else if (value is double) {
      sp.setDouble(key, value);
    } else if (value is bool) {
      sp.setBool(key, value);
    } else if (value is List<String>) {
      sp.setStringList(key, value);
    } else {
      sp.setString(key, json.encode(value));
    }
  }

  static setString(String key, String value) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  static setInt(String key, int value) async {
    var sp = await SharedPreferences.getInstance();
    sp.setInt(key, value);
  }

  static setDouble(String key, double value) async {
    var sp = await SharedPreferences.getInstance();
    sp.setDouble(key, value);
  }

  static setBoolean(String key, bool value) async {
    var sp = await SharedPreferences.getInstance();
    sp.setBool(key, value);
  }

  static setStringList(String key, List<String> value) async {
    var sp = await SharedPreferences.getInstance();
    sp.setStringList(key, value);
  }

  static Future<dynamic> get(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.get(key);
  }

  static getInt(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }

  static getDouble(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getDouble(key);
  }

  static getString(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static getBoolean(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getDouble(key);
  }

  static getStringList(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }
}
