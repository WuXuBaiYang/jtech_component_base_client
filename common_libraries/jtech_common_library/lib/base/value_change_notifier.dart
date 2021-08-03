import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/*
* 数据变化监听
* @author wuxubaiyang
* @Time 2021/7/6 上午10:33
*/
class ValueChangeNotifier<V> extends ChangeNotifier
    implements ValueListenable<V> {
  //参数数据
  V _value;

  ValueChangeNotifier(this._value);

  @override
  V get value => _value;

  //赋值并刷新
  setValue(V newValue, {bool notify = true}) {
    if (newValue == _value) return;
    _value = newValue;
    update(notify);
  }

  //刷新
  void update(bool notify) {
    if (notify) notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($_value)';
}

/*
* 集合数据变化监听
* @author wuxubaiyang
* @Time 2021/7/6 下午3:21
*/
class ListValueChangeNotifier<V> extends ValueChangeNotifier<List<V>> {
  ListValueChangeNotifier(List<V> value) : super(value);

  ListValueChangeNotifier.empty() : this([]);

  //清除数据
  void clear() => value.clear();

  //获取数据长度
  int get length => value.length;

  //添加数据
  void addValue(List<V> newValue, {bool notify = true}) {
    value.addAll(newValue);
    update(notify);
  }

  //插入数据
  void insertValue(int index, List<V> newValue, {bool notify = true}) {
    value.insertAll(index, newValue);
    update(notify);
  }

  //更新/添加数据
  void putValue(int index, V item, {bool notify = true}) {
    value[index] = item;
    update(notify);
  }

  //移除数据
  bool removeValue(V item, {bool notify = true}) {
    var result = value.remove(item);
    update(notify);
    return result;
  }

  //移除下标数据
  V? removeValueAt(int index, {bool notify = true}) {
    var result = value.removeAt(index);
    update(notify);
    return result;
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';

  @override
  void dispose() {
    super.dispose();
    value.clear();
  }
}

/*
* 表数据变化监听
* @author wuxubaiyang
* @Time 2021/7/6 下午4:09
*/
class MapValueChangeNotifier<K, V> extends ValueChangeNotifier<Map<K, V>> {
  MapValueChangeNotifier(Map<K, V> value) : super(value);

  MapValueChangeNotifier.empty() : this({});

  //清除数据
  void clear() => value.clear();

  //添加数据
  void putValue(K k, V v, {bool notify = true}) {
    value.addAll({k: v});
    update(notify);
  }

  //移除数据
  V? removeValue(K key, {bool notify = true}) {
    var result = value.remove(key);
    update(notify);
    return result;
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';

  @override
  void dispose() {
    super.dispose();
    value.clear();
  }
}
