import 'package:jtech_component_library/jcomponent.dart';

/*
* 登录的用户信息
* @author wuxubaiyang
* @Time 2021/9/27 15:39
*/
class LoginUserModel extends BaseModel {
  String name;
  int age;
  String sex;

  LoginUserModel(this.name, this.age, this.sex);

  @override
  void from(obj) {
    this.name = obj["name"];
    this.age = obj["age"];
    this.sex = obj["sex"];
  }

  @override
  Map<String, dynamic> to() {
    return {
      "name": name,
      "age": age,
      "sex": sex,
    };
  }
}
