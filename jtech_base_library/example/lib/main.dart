import 'package:flutter/material.dart';
import 'package:jtech_base_library/jbase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends BaseStatelessPage {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage("JTech base library"),
    );
  }
}

class MyHomePage extends BaseStatefulPage {
  //标题
  final String title;

  MyHomePage(this.title);

  @override
  BaseState<BaseStatefulWidget> getState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
    );
  }
}
