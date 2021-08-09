import 'package:jtech_common_library/base/refresh/config.dart';

/*
* 表格刷新组件配置文件
* @author jtechjh
* @Time 2021/8/9 2:49 下午
*/
class RefreshGridConfig<V> extends RefreshConfig<V> {
  //副方向上的最大元素数量
  final int crossAxisCount;

  //主方向元素间距
  final double mainAxisSpacing;

  //副方向元素间距
  final double crossAxisSpacing;

  RefreshGridConfig({
    bool enablePullDown = false,
    bool enablePullUp = false,
    Function? onPullDownRefreshing,
    Function? onPullUpLoading,
    OnRefreshLoad<V>? onRefreshLoad,
    RefreshHeader? header,
    LoadFooter? footer,
    this.crossAxisCount = 4,
    this.mainAxisSpacing = 4.0,
    this.crossAxisSpacing = 4.0,
  }) : super(
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
          onPullDownRefreshing: onPullDownRefreshing,
          onPullUpLoading: onPullUpLoading,
          onRefreshLoad: onRefreshLoad,
          header: header,
          footer: footer,
        );

  RefreshGridConfig<V> copyWith({
    bool? enablePullDown,
    bool? enablePullUp,
    Function? onPullDownRefreshing,
    Function? onPullUpLoading,
    OnRefreshLoad<V>? onRefreshLoad,
    RefreshHeader? header,
    LoadFooter? footer,
    int? crossAxisCount,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
  }) {
    return RefreshGridConfig<V>(
      enablePullDown: enablePullDown ?? this.enablePullDown,
      enablePullUp: enablePullUp ?? this.enablePullUp,
      onPullDownRefreshing: onPullDownRefreshing ?? this.onPullDownRefreshing,
      onPullUpLoading: onPullUpLoading ?? this.onPullUpLoading,
      onRefreshLoad: onRefreshLoad ?? this.onRefreshLoad,
      header: header ?? this.header,
      footer: footer ?? this.footer,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
    );
  }
}
