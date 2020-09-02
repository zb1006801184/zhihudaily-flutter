import 'package:flutter/material.dart';
import '../unitls/nav_bar_config.dart';
import '../unitls/global.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {


//点击收藏和消息
  _itemClick({String title}){
    Navigator.of(context).pushNamed("/MineMessage",arguments: title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar("", context),
      backgroundColor: Colors.white,
      body: Container(
        width: Global.ksWidth,
        height: Global.ksHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTopWidget(),
            _buildBottomWidget(),
          ],
        ),
      ),
    );
  }

  //头像和昵称
  Widget _buildTopWidget() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: new DecorationImage(
                image: new AssetImage("images/mine_head.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "zhub",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          _lines(top: 20),
          _buildItem(title: '我的收藏'),
          _lines(),
          _buildItem(title: '消息中心'),
        ],
      ),
    );
  }

  //lines
  Widget _lines({double top = 0.0}) {
    return Container(
      margin: EdgeInsets.only(top: top),
      height: 1,
      width: Global.ksWidth,
      color: Color(0xfff4f5f7),
    );
  }

  //列表item
  Widget _buildItem({String title}) {
    return InkWell(
      child: Container(
      height: 48,
      width: Global.ksWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: 16,
            ),
            child: Icon(
              Icons.keyboard_arrow_right,
              color: Color(0xFFf4f5f7),
            ),
          ),
        ],
      ),
    ),
    onTap: (){
    _itemClick(title: title);
    },
    );
  }

  Widget _buildBottomWidget() {
    Widget _buildIcon({String title, String icon}) {
      return Container(
        width: 65,
        height: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(icon),
              height: 40,
              width: 40,
            ),
            Container(
              child: Text(title),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: Global.ksBottomBar),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIcon(title: '夜间模式', icon: 'images/mine_night.png'),
          _buildIcon(title: '设置', icon: 'images/mine_setting.png'),
        ],
      ),
    );
  }
}
