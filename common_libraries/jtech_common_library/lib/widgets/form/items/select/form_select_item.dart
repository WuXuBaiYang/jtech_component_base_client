import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jtech_common_library/jcommon.dart';

//自定义展示文本构造器
typedef OnCustomTextBuilder<T extends SelectItem> = String Function(
    List<T> selectedItems);

//自定义选择页面/弹层构造器
typedef OnCustomSelectBuilder<T extends SelectItem> = Future<List<T>?> Function(
    List<T> items, List<T> selectedItems, int maxSelect);

/*
* 表单文本子项
* @author wuxubaiyang
* @Time 2021/7/22 下午3:23
*/
class JFormSelectItemState<T extends SelectItem>
    extends BaseJFormItemState<List<T>> {
  //原始数据集
  final List<T> originList;

  //文本内容文字样式
  final TextStyle textStyle;

  //文本对齐方式
  final TextAlign textAlign;

  //自定义展示文本构造器
  final OnCustomTextBuilder<T>? customTextBuilder;

  //最大选择数(如果用户启用自定义选择方法，则最大选择数会限制用户返回的结果)
  final int maxSelect;

  //自定义选择弹层/页面
  final OnCustomSelectBuilder<T>? customSelectBuilder;

  JFormSelectItemState({
    TextStyle? textStyle,
    this.textAlign = TextAlign.start,
    this.originList = const [],
    this.customTextBuilder,
    this.maxSelect = 1,
    this.customSelectBuilder,
  })  : assert(maxSelect > 0, "最大选择数不可小于等于0"),
        this.textStyle = textStyle ?? TextStyle(color: Colors.grey[600]);

  @override
  Widget buildFormItem(BuildContext context, FormFieldState<List<T>> field) {
    return buildDefaultItem(
      field: field,
      child: Text(
        customTextBuilder?.call(field.value ?? []) ??
            field.value?.map((e) => e.text).join(",") ??
            "",
        style: textStyle,
        textAlign: textAlign,
      ),
      defaultConfig: widget.defaultConfig?.copyWith(
        onTap: (value) async {
          widget.defaultConfig?.onTap?.call(value);
          value = await showSelectMenu(context, value);
          field.didChange(value);
        },
      ),
    );
  }

  //展示选择菜单集合
  Future<List<T>?> showSelectMenu(BuildContext context, List<T>? value) async {
    if (null != customSelectBuilder) {
      return customSelectBuilder!(originList, value ?? [], maxSelect);
    } else {
      var tmpValue = List<T>.from(value ?? []);
      return jSheet.showCustomBottomSheet(
        context,
        config: SheetConfig(
          title: widget.defaultConfig?.title,
          contentPadding: EdgeInsets.zero,
          cancelItem: Icon(Icons.close),
          cancelTap: () => value,
          confirmItem: Icon(Icons.done_all),
          confirmTap: () => tmpValue,
          content: StatefulBuilder(
            builder: (context, setState) => ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: originList.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                var item = originList[index];
                var isSelected = tmpValue.contains(item);
                return ListTile(
                  title: Text(item.text),
                  trailing: Visibility(
                    visible: isSelected,
                    child: Icon(
                      Icons.check,
                      color: Colors.blueAccent,
                    ),
                  ),
                  onTap: () => setState(() {
                    if (isSelected) {
                      tmpValue.remove(item);
                    } else {
                      if (maxSelect == 1) tmpValue.clear();
                      if (maxSelect > tmpValue.length) tmpValue.add(item);
                    }
                  }),
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
