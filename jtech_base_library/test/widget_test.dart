import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jtech_base_library/base/base_page.dart';
import 'package:jtech_base_library/event/base_event_model.dart';

void main() {
  testWidgets("基类测试", (tester) async {
    tester.pumpWidget(MyApp());
  });

  test("消息总线测试", () {
    Uri u = Uri.parse("/home/message?p1=xx&p2=&p3=0");
    var a = u.queryParameters;
    var b = u.path;
    print("object");
  });
}

class CusEvent extends BaseEventModel {
  String text = "";

  CusEvent(this.text);
}

//测试基本页面
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TestPage(),
    );
  }
}

//测试页面
class TestPage extends BasePage {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("标题"),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
