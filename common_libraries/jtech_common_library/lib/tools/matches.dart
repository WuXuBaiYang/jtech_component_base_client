import 'package:jtech_base_library/jbase.dart';

/*
* 匹配工具
* @author wuxubaiyang
* @Time 2021/7/23 下午4:17
*/
class JMatches extends BaseManage {
  static final JMatches _instance = JMatches._internal();

  factory JMatches() => _instance;

  JMatches._internal();

  @override
  Future<void> init() async {}

  //手机号正则
  final _phoneNumberRegExp = RegExp(
      r'^((\+86)?|(\+86-)?)1(3\d|4[5-9]|5[0-35-9]|6[2567]|7[0-8]|8\d|9[0-35-9])\d{8}$');

  //匹配手机号(+86)
  bool hasPhoneNumber_86(String string) =>
      hasMatch(_phoneNumberRegExp, string: string);

  //邮箱正则
  final _emailAddressRegExp =
      RegExp(r'^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$');

  //匹配邮箱
  bool hasEmailAddress(String string) =>
      hasMatch(_emailAddressRegExp, string: string);

  //身份证号正则
  final _idCardRegExp = RegExp(r'(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)');

  //匹配身份证号
  bool hasIDCard(String string) => hasMatch(_idCardRegExp, string: string);

  //图片文件类型正则
  final _imageTypeRegExp = RegExp(
      r'xbm|tif|pjp|svgz|jpg|jpeg|ico|tiff|gif|svg|jfif|webp|png|bmp|pjpeg|avif');

  //判断是否为图片类型
  bool isImageFile(String string) => hasMatch(_imageTypeRegExp, string: string);

  //视频文件类型正则
  final _videoTypeRegExp = RegExp(r'mp4|avi|wmv|mpg|mpeg|mov|rm|ram|swf|flv');

  //判断是否为视频类型
  bool isVideoFile(String string) => hasMatch(_videoTypeRegExp, string: string);

  //音频文件类型正则
  final _audioTypeRegExp = RegExp(
      r'opus|flac|webm|weba|wav|ogg|m4a|mp3|oga|mid|amr|aiff|wma|au|aac');

  //判断是否为音频类型
  bool isAudioFile(String string) => hasMatch(_audioTypeRegExp, string: string);

  //判断是否存在匹配内容
  bool hasMatch(Pattern pattern, {required String string}) =>
      match(pattern, string: string).isNotEmpty;

  //匹配所有内容
  Iterable<Match> match(Pattern pattern, {required String string}) =>
      pattern.allMatches(string);
}

//单例调用
final jMatches = JMatches();
