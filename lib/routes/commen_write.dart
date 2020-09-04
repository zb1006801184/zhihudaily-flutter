import 'package:flutter/material.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';
import 'package:zhihudaily_flutter/unitls/nav_bar_config.dart';
import 'package:zhihudaily_flutter/unitls/them_util.dart';

class CommenWrite extends StatefulWidget {
  @override
  _CommenWriteState createState() => _CommenWriteState();
}

class _CommenWriteState extends State<CommenWrite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configCommenWriteAppBar("写点评", context, _action()),
      backgroundColor: ThemUntil().mainColor(context),
      body: Container(
        width: Global.ksWidth,
        height: Global.ksHeight,
        padding: EdgeInsets.only(left: 20,right: 20),
        child: TextField(
          style: TextStyle(fontSize: 18),
          // keyboardType: TextInputType.number,
          maxLines: 99,
          showCursor: true,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 1),
              hintStyle: TextStyle(color: Color(0xFFAEAFB7), fontSize: 16),
              hintText: '友善的评论是交流的起点...'),
        ),
      ),
    );
  }

  List<Widget> _action() {
    List<Widget> result = [];
    result.add(InkWell(
      child: Center(
          child: Padding(
        padding: EdgeInsets.only(right: 16, left: 16),
        child: Text(
          "发布",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      )),
      onTap: () {
        Navigator.of(context).pop();
      },
    ));
    return result;
  }
}
