import 'package:flutter_test/flutter_test.dart';
import 'package:jtech_common_library/jcommon.dart';

void main() {
  test("测试url拼接", () {
    var a = "pathA";
    var b = "fileName.jpg";
    var c = join(a, b);
    print("$c");
  });
}
