import 'package:flutter/material.dart';
import 'package:zhihudaily_flutter/common/common_tool.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';

class HomeAppBar {
  AppBar buildAppBar(Function rightAction) {
    DateTime nowTime = DateTime.now();
    return AppBar(
      actions: [
        Container(
          width: Global.ksWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${nowTime.day}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            CommonTool().changeMouth(nowTime.month),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 0.3,
                      height: 35,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        "知乎日报",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                color: Colors.grey,
                icon: Icon(Icons.settings),
                onPressed: rightAction,
              ),
            ],
          ),
        )
      ],
      backgroundColor: Color(0xFFf4f5f7),
      elevation: 0,
      brightness: Brightness.light,
    );
  }
}
