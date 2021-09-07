import 'dart:convert';

import 'package:flutter/material.dart';

/*
* 数据对象基类
* @author jtechjh
* @Time 2021/8/13 8:56 上午
*/
abstract class BaseModel {
  //解析json
  BaseModel fromJson(Map<String, dynamic> json) => this;

  //从json字符串解析
  @protected
  BaseModel fromJsonString(String json) => fromJson(jsonDecode(json));

  //转化json
  Map<String, dynamic> toJson() => {};

  //转化为json字符串
  @protected
  String toJsonString() => jsonEncode(toJson());
}
