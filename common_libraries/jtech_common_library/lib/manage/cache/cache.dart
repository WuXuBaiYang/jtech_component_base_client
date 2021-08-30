import 'dart:async';
import 'dart:convert';

import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
* 缓存管理(字段、参数、文件，时效)
* @author jtechjh
* @Time 2021/8/30 10:09 上午
*/
class JCacheManage extends BaseManage {
  //时效字段后缀
  final String expirationSuffix = "expiration";

  static final JCacheManage _instance = JCacheManage._internal();

  factory JCacheManage() => _instance;

  JCacheManage._internal();

  //sp存储方法
  late SharedPreferences _sp;

  @override
  Future<void> init() async {
    //创建sp单例
    _sp = await SharedPreferences.getInstance();
  }

  //获取int类型
  int? getInt(String key) {
    if (!_checkExpiration(key)) return null;
    return _sp.getInt(key);
  }

  //获取bool类型
  bool? getBool(String key) {
    if (!_checkExpiration(key)) return null;
    return _sp.getBool(key);
  }

  //获取double类型
  double? getDouble(String key) {
    if (!_checkExpiration(key)) return null;
    return _sp.getDouble(key);
  }

  //获取String类型
  String? getString(String key) {
    if (!_checkExpiration(key)) return null;
    return _sp.getString(key);
  }

  //获取StringList类型
  List<String>? getStringList(String key) {
    if (!_checkExpiration(key)) return null;
    return _sp.getStringList(key);
  }

  //获取json类型
  dynamic getJson(String key) {
    if (!_checkExpiration(key)) return null;
    var value = _sp.getString(key);
    if (null == value) return null;
    return jsonDecode(value);
  }

  //设置int类型
  Future<bool> setInt(
    String key,
    int value, {
    Duration? expiration,
  }) async {
    if (!await _setupExpiration(key)) return false;
    return _sp.setInt(key, value);
  }

  //设置double类型
  Future<bool> setDouble(
    String key,
    double value, {
    Duration? expiration,
  }) async {
    if (!await _setupExpiration(key)) return false;
    return _sp.setDouble(key, value);
  }

  //设置bool类型
  Future<bool> setBool(
    String key,
    bool value, {
    Duration? expiration,
  }) async {
    if (!await _setupExpiration(key)) return false;
    return _sp.setBool(key, value);
  }

  //设置string类型
  Future<bool> setString(
    String key,
    String value, {
    Duration? expiration,
  }) async {
    if (!await _setupExpiration(key)) return false;
    return _sp.setString(key, value);
  }

  //设置List<string>类型
  Future<bool> setStringList(
    String key,
    List<String> value, {
    Duration? expiration,
  }) async {
    if (!await _setupExpiration(key)) return false;
    return _sp.setStringList(key, value);
  }

  //设置JsonMap类型
  Future<bool> setJsonMap<K, V>(
    String key,
    Map<K, V> value, {
    Duration? expiration,
  }) async {
    if (!await _setupExpiration(key)) return false;
    return _sp.setString(key, jsonEncode(value));
  }

  //设置JsonList类型
  Future<bool> setJsonList<V>(
    String key,
    List<V> value, {
    Duration? expiration,
  }) async {
    if (!await _setupExpiration(key)) return false;
    return _sp.setString(key, jsonEncode(value));
  }

  //移除字段
  Future<bool> remove(String key) {
    return _sp.remove(key);
  }

  //清空缓存的所有字段
  Future<bool> clearAll() {
    return _sp.clear();
  }

  //检查有效期
  bool _checkExpiration(String key) {
    var expirationKey = _getExpirationKey(key);
    if (_sp.containsKey(expirationKey)) {
      var expirationTime =
          DateTime.fromMillisecondsSinceEpoch(_sp.getInt(expirationKey) ?? 0);
      if (expirationTime.isBefore(DateTime.now())) {
        remove(expirationKey);
        remove(key);
        return false;
      }
    }
    return true;
  }

  //设置有效期
  Future<bool> _setupExpiration(String key, {Duration? expiration}) async {
    if (null == expiration) return true;
    var expirationKey = _getExpirationKey(key);
    var inTime = DateTime.now().add(expiration).millisecondsSinceEpoch;
    return _sp.setInt(expirationKey, inTime);
  }

  //获取有效期的存储字段
  String _getExpirationKey(String key) {
    key = "${key}_$expirationSuffix";
    return "${key}_${jTools.md5(key)}";
  }
}

//单例调用
final jCache = JCacheManage();
