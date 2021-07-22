import 'package:flutter/cupertino.dart';
import 'package:jtech_common_library/base/controller.dart';

/*
* 表单控制器
* @author wuxubaiyang
* @Time 2021/7/22 下午2:21
*/
class JFormController extends BaseController {
  //实例化表单状态key
  final GlobalKey<FormState> _formKey;

  JFormController() : this._formKey = GlobalKey();

  //获取表单key
  GlobalKey<FormState> get formKey => _formKey;

  //数据校验
  bool validate() => _formKey.currentState!.validate();

  //数据存储
  void save() => _formKey.currentState!.save();

  //数据提交-先校验再存储
  void submit() => _formKey.currentState!
    ..validate()
    ..save();
}
