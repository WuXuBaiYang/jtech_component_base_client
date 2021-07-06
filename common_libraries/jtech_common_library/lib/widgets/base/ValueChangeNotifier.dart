import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/*
* 数据变化监听
* @author wuxubaiyang
* @Time 2021/7/6 上午10:33
*/
class ValueChangeNotifier<V> extends ChangeNotifier
    implements ValueListenable<V> {
  ValueChangeNotifier(this._value);

  V _value;

  @override
  V get value => _value;

  //触发监听
  void update() => notifyListeners();

  set value(V newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  void setValueWithNoNotify(V newValue) {
    if (_value == newValue) return;
    _value = newValue;
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}
