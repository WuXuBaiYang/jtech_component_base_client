import 'package:jtech_base_library/jbase.dart';
import 'package:jtech_common_library/jcommon.dart';

/*
* 管理入口
* @author jtechjh
* @Time 2021/8/30 10:11 上午
*/
class JManage extends BaseManage {
  static final JManage _instance = JManage._internal();

  factory JManage() => _instance;

  JManage._internal();

  //接口取消管理
  final apiCancel = JAPICancelManage();

  //缓存管理
  final cache = JCacheManage();

  //本地通知管理
  final notification = JNotificationManage();

  @override
  Future<void> init() async {
    //初始化接口取消管理
    await apiCancel.init();
    //初始化缓存管理
    await cache.init();
    //初始化通知管理
    await notification.init();
  }
}

//单例调用
final jManage = JManage();
