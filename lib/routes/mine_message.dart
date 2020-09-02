import 'package:flutter/material.dart';
import '../unitls/nav_bar_config.dart';

class MineMessage extends StatefulWidget {
  @override
  _MineMessageState createState() => _MineMessageState();
}

class _MineMessageState extends State<MineMessage> {
  @override
  Widget build(BuildContext context) {
    String title = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: NavBarConfig().configAppBar(title, context),
      body: Center(
        child: Text('还没有数据'),
      ),
    );
  }
}
