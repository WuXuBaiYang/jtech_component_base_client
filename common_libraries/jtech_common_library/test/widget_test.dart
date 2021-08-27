import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jtech_common_library/jcommon.dart';

void main() {
  test("测试url拼接", () {
    var a = "pathA";
    var b = "fileName.jpg";
    var c = join(a, b);
    print("$c");
  });

  test("测试接口请求对象表单构造方法", () {
    var a = RequestModel.form()
        .add("k1", "v1")
        .add("k2", 2)
        .add("k3", true)
        .build();
    print("$a");
  });
}
