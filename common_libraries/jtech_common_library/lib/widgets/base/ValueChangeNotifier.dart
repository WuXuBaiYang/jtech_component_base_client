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

  V? _value;

  @override
  V get value => _value!;

  //赋值并刷新
  setValue(V newValue, {bool notify = true}) {
    if (newValue == _value) return;
    _value = newValue;
    update(true);
  }

  //刷新
  void update(bool notify) {
    if (notify) notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}

/*
* 集合数据变化监听
* @author wuxubaiyang
* @Time 2021/7/6 下午3:21
*/
class ListValueChangeNotifier<V> extends ValueChangeNotifier<List<V>> {
  ListValueChangeNotifier(List<V>? value) : super(value);

  //清除数据
  void clear() => _value?.clear();

  //检查集合是否为空
  bool get isListEmpty => null == _value || value.isEmpty;

  //添加数据
  void addValue(List<V> newValue, {bool notify = true}) {
    if (isListEmpty) _value = [];
    _value?.addAll(newValue);
    update(notify);
  }

  //插入数据
  void insertValue(List<V> newValue, {required int index, bool notify = true}) {
    if (isListEmpty) _value = [];
    _value?.insertAll(index, newValue);
    update(notify);
  }

  //移除数据
  bool removeValue(V item, {bool notify = true}) {
    if (isListEmpty) return false;
    var result = _value?.remove(item) ?? false;
    update(notify);
    return result;
  }

  //移除下标数据
  V? removeValueAt(int index, {bool notify = true}) {
    if (isListEmpty) return null;
    var result = _value?.removeAt(index);
    update(notify);
    return result;
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}

/*
* 表数据变化监听
* @author wuxubaiyang
* @Time 2021/7/6 下午4:09
*/
class MapValueChangeNotifier<K, V> extends ValueChangeNotifier<Map<K, V>> {
  MapValueChangeNotifier(Map<K, V>? value) : super(value);

  //清除数据
  void clear() => _value?.clear();

  //检查集合是否为空
  bool get _isMapEmpty => null == _value || value.isEmpty;

  //添加数据
  void putValue(K key, V value, {bool notify = true}) {
    if (_isMapEmpty) _value = {};
    _value![key] = value;
    update(notify);
  }

  //移除数据
  V? removeValue(String key, {bool notify = true}) {
    if (_isMapEmpty) return null;
    var result = _value?.remove(key);
    update(notify);
    return result;
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}
