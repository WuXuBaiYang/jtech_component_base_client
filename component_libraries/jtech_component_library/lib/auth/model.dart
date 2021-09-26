import 'package:jtech_component_library/jcomponent.dart';

/*
* 授权信息管理基类
* @author wuxubaiyang
* @Time 2021/9/24 16:50
*/
class AuthModel extends BaseModel {
  //标识字段
  String _key;

  //授权凭证
  String _token;

  //是否正在使用
  bool _active;

  String get key => _key;

  String get token => _token;

  bool get active => _active;

  //修改active状态
  set modifyActive(bool active) => _active = active;

  AuthModel({
    required String token,
    String? key,
    bool active = true,
  })  : this._key = key ?? jTools.generateID(),
        this._token = token,
        this._active = active;

  AuthModel.from(obj)
      : _key = obj["key"],
        _token = obj["token"],
        _active = obj["active"];

  @override
  Map<String, dynamic> to() => {
        "key": _key,
        "token": _token,
        "active": _active,
      };
}
