import 'dart:convert';

import 'package:jtech_component_library/jcomponent.dart';

/*
* 授权方法入口
* @author wuxubaiyang
* @Time 2021/9/24 16:40
*/
class JAuthManage extends BaseManage {
  //授权信息缓存key
  static final String authCacheKey = "auth_cache_key";

  //授权信息扩展存储key
  static final String authCacheExtKey = "auth_cache_ext_key";

  //缓存当前授权对象表
  late Map<String, AuthModel> _authMap;

  //sp缓存管理
  late SharedPreferences _sp;

  @override
  Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
    _authMap = _getJsonCache(authCacheKey, {}).map<String, AuthModel>(
      (k, v) => MapEntry(k, AuthModel.from(v)),
    );
  }

  //登录
  Future<bool> login<T extends BaseModel>(
    AuthModel authModel, {
    T? extData,
  }) async {
    _authMap.values.forEach((item) => item.active = false);
    authModel.active = true;
    return update(authModel, extData: extData);
  }

  //更新授权信息
  Future<bool> update<T extends BaseModel>(
    AuthModel authModel, {
    T? extData,
  }) async {
    _authMap[authModel.key] = authModel;
    var extCacheState = true;
    if (null != extData) {
      extCacheState = await _updateAuthExtCache(authModel.key, extData);
    }
    return extCacheState && await _updateAuthCache();
  }

  //注销
  Future<bool> logout({bool delete = true}) async {
    var loginAuth = getLoginInfo();
    if (null == loginAuth) return false;
    loginAuth.active = false;
    var removeState = true;
    if (delete) removeState = await removeAuth(loginAuth.key);
    return removeState && await _updateAuthCache();
  }

  //判断是否已登录（是否存在激活的授权信息）
  bool isLogin() => _authMap.values.any((item) => item.active);

  //获取单个的授权信息
  AuthModel? getAuthInfo(String key) {
    if (key.isEmpty || !_authMap.containsKey(key)) return null;
    return _authMap[key];
  }

  //获取所有授权信息
  List<AuthModel> getAuthList() => _authMap.values.toList();

  //获取已登录账户（激活状态的授权信息）
  AuthModel? getLoginInfo() {
    for (var item in _authMap.values) {
      if (item.active) return item;
    }
    return null;
  }

  //移除授权信息
  Future<bool> removeAuth(String key) async {
    if (key.isEmpty || !_authMap.containsKey(key)) return false;
    return null != _authMap.remove(key) &&
        await _sp.remove(_getAuthExtKey(key));
  }

  //获取当前登录的附带信息
  T? getLoginExtInfo<T extends BaseModel>(T extData) {
    var loginAuth = getLoginInfo();
    if (null == loginAuth) return null;
    var extCacheKey = _getAuthExtKey(loginAuth.key);
    var extJson = _getJsonCache(extCacheKey, {});
    return extData..from(extJson);
  }

  //获取授权扩展数据字段key
  String _getAuthExtKey(String key) => "${authCacheExtKey}_$key";

  //更新授权对应的扩展数据
  Future<bool> _updateAuthExtCache<T extends BaseModel>(
      String authKey, T extData) async {
    var extCacheKey = _getAuthExtKey(authKey);
    return _setJsonCache(extCacheKey, extData.to());
  }

  //更新存储状态
  Future<bool> _updateAuthCache() async {
    var cacheJson = _authMap.map<String, dynamic>(
      (key, value) => MapEntry(key, value.to()),
    );
    return _setJsonCache(authCacheKey, cacheJson);
  }

  //读取json格式的对象
  Map<String, dynamic> _getJsonCache(String key, Map<String, dynamic> def) {
    return jsonDecode(_sp.getString(key) ?? "{}") ?? def;
  }

  //写入json格式对象
  Future<bool> _setJsonCache(String key, Map<String, dynamic> value) {
    return _sp.setString(key, jsonEncode(value));
  }
}

//单例调用
final jAuth = JAuthManage();
