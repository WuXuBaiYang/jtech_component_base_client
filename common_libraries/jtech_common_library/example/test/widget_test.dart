// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';
import 'package:package:jtech_common_library/jcommon.dart';

void main() {
  testWidgets("common test", (WidgetTester tester) async {
    // String a = r'!@#$%^&*QWERTYUIOPASDFGHJKLZXCVBNM';
    // List<String> json = [];
    // a.characters.forEach((it) {
    //   json.add(it);
    // });
    // var result = jsonEncode(json);
    // print("");
    var result = jCommon.tools.file.getFileSize(1024 * 1024+102411);
    print("");
  });
}
