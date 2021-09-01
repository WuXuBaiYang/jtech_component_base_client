import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 预览工具方法
* @author jtechjh
* @Time 2021/8/23 10:12 上午
*/
class JPreview extends BaseManage {
  static final JPreview _instance = JPreview._internal();

  factory JPreview() => _instance;

  JPreview._internal();

  //展示附件预览
  Future<int?>? show({
    required List<JFileInfo> fileList,
    PreviewItemBuilder? itemBuilder,
    bool showAppbar = false,
    String? title,
    bool showCounter = true,
    PreviewConfig? config,
    int initialIndex = 0,
  }) {
    return jRouter.push<int>(PreviewPage(
      fileList: fileList,
      initialIndex: initialIndex,
      config: (config ?? PreviewConfig()).copyWith(
        itemBuilder: itemBuilder,
        showAppbar: showAppbar,
        title: title,
        showCounter: showCounter,
      ),
    ));
  }
}

//单例调用
final jPreview = JPreview();
