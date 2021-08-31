import 'package:flutter_test/flutter_test.dart';
import 'package:jtech_common_library/jcommon.dart';

void main() {
  testWidgets("common test", (WidgetTester tester) async {});

  test("CacheManage 写入测试", () async {
    await jCache.init();
    jCache.setString("string_key", "字符串字段", expiration: Duration(seconds: 50));
    jCache.setStringList("string_list_key", ["str1"],
        expiration: Duration(hours: 24));
    jCache.setDouble("double_key", 1.0);
    jCache.setInt("ink_key", 1);
    jCache.setBool("bool_key", true);
    jCache.setJsonList("json_list_key", [
      {"name": "张"},
      {"name": "李"}
    ]);
    jCache.setJsonMap("json_map_key", {
      "name": "张",
      "sex": 0,
    });
  });

  test("CacheManage 读取测试", () async {
    await jCache.init();
    var a = jCache.getString("string_key");
    var b = jCache.getStringList("string_list_key", def: []);
    var c = jCache.getDouble("double_key", def: 0.0);
    var d = jCache.getInt("ink_key");
    var e = jCache.getBool("bool_key");
    var f = jCache.getJson("json_list_key");
    var g = jCache.getJson("json_map_key");
  });
}
