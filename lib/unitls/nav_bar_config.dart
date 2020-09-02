import 'package:flutter/material.dart';

class NavBarConfig {
  AppBar configAppBar(String title,BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,), onPressed: (){
        Navigator.pop(context);
      }),
      backgroundColor: Colors.white,
      elevation: 0, //阴影辐射范围
      brightness: Brightness.light,
    );
  }

  AppBar configAppBarRobot(String title, BuildContext context) {
    Widget _buildLeadingWidget() {
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 16),
          //不添加装饰器空白部分无法响应点击
          decoration: BoxDecoration(),
          width: 32,
          height: 32,
          child: Row(
            children: [
              Image(
                image: AssetImage("images/nav_icon_back.png"),
                width: 10,
                height: 20,
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      );
    }

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
      ),
      leading: _buildLeadingWidget(),
      backgroundColor: Colors.white,
      elevation: 0, //阴影辐射范围
      brightness: Brightness.light,
    );
  }
}
