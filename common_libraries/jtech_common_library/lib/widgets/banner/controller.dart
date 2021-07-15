import 'package:jtech_common_library/base/controller.dart';
import 'package:jtech_common_library/base/value_change_notifier.dart';
import 'package:jtech_common_library/widgets/banner/item.dart';

//banner变化监听
typedef OnBannerChange = void Function(int index);

/*
* banner控制器
* @author wuxubaiyang
* @Time 2021/7/13 下午5:16
*/
class BannerController<T extends BannerItem> extends BaseController {
  //子项对象集合
  List<T> _items;

  //当前所在下标
  ValueChangeNotifier<int> _currentIndex;

  BannerController({
    required List<T> items,
    int initialIndex = 0,
  })  : this._items = items,
        _currentIndex = ValueChangeNotifier(initialIndex);

  //获取当前下标
  int get currentIndex => _currentIndex.value;

  //获取数据长度
  int get itemLength => _items.length;

  //获取数据子项
  T getItem(int index) => _items[index];

  //选中一个下标
  void select(int index) {
    if (index < 0 || index > _items.length) index = 0;
    _currentIndex.setValue(index);
  }

  //添加下标变化监听
  void addChangeListener(OnBannerChange onChange) =>
      _currentIndex.addListener(() => onChange(currentIndex));

  @override
  void dispose() {
    super.dispose();
    //销毁数据
    _currentIndex.dispose();
    _items.clear();
  }
}
