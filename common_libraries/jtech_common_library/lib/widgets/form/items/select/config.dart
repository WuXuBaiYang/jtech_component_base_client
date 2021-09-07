import 'package:jtech_base_library/jbase.dart';

/*
* 表单选择组件选择子项
* @author jtechjh
* @Time 2021/9/6 2:35 下午
*/
class SelectItem extends BaseModel {
  //选择项标标识
  dynamic id;

  //选择项展示文本
  String text;

  SelectItem({
    required this.id,
    required this.text,
  });

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}
