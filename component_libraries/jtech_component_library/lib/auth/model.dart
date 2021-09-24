import 'package:jtech_component_library/jcomponent.dart';

/*
* 授权信息管理基类
* @author wuxubaiyang
* @Time 2021/9/24 16:50
*/
class AuthModel extends BaseModel {
  //用户id
  String id;

  //授权凭证
  String token;

  //是否正在使用
  bool active;

  AuthModel({
    required this.id,
    required this.token,
    this.active = true,
  });

  //转换为json存储
  Map<String, dynamic> toMap() => {
        "id": id,
        "token": token,
        "active": active,
      }..addAll(handleExtData());

  //存储额外数据
  Map<String, dynamic> handleExtData() => {};
}
