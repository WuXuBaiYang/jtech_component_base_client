import 'package:jtech_common_library/base/refresh/config.dart';

/*
* 刷新列表组件配置对象
* @author jtechjh
* @Time 2021/8/9 3:27 下午
*/
class RefreshListConfig<V> extends RefreshConfig<V> {
  RefreshListConfig({
    bool enablePullDown = false,
    bool enablePullUp = false,
    Function? onPullDownRefreshing,
    Function? onPullUpLoading,
    OnRefreshLoad<V>? onRefreshLoad,
    RefreshHeader? header,
    LoadFooter? footer,
  }) : super(
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
          onPullDownRefreshing: onPullDownRefreshing,
          onPullUpLoading: onPullUpLoading,
          onRefreshLoad: onRefreshLoad,
          header: header,
          footer: footer,
        );

  @override
  RefreshListConfig<V> copyWith({
    bool? enablePullDown,
    bool? enablePullUp,
    Function? onPullDownRefreshing,
    Function? onPullUpLoading,
    OnRefreshLoad<V>? onRefreshLoad,
    RefreshHeader? header,
    LoadFooter? footer,
  }) {
    return RefreshListConfig<V>(
      enablePullDown: enablePullDown ?? this.enablePullDown,
      enablePullUp: enablePullUp ?? this.enablePullUp,
      onPullDownRefreshing: onPullDownRefreshing ?? this.onPullDownRefreshing,
      onPullUpLoading: onPullUpLoading ?? this.onPullUpLoading,
      onRefreshLoad: onRefreshLoad ?? this.onRefreshLoad,
      header: header ?? this.header,
      footer: footer ?? this.footer,
    );
  }
}
