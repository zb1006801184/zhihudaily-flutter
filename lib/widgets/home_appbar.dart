import 'package:flutter/material.dart';
import 'package:zhihudaily_flutter/common/common_tool.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';
import 'package:zhihudaily_flutter/unitls/them_util.dart';

class HomeAppBar {
  AppBar buildAppBar(Function rightAction, BuildContext context) {
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
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: ThemUntil().widgetColor(context)),
                          ),
                          Text(
                            CommonTool().changeMouth(nowTime.month),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: ThemUntil().widgetColor(context),
                            ),
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
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: ThemUntil().widgetColor(context),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                color: Colors.grey,
                icon: Image(
                  image: AssetImage("images/mine_head.png"),
                  width: 30,
                  height: 30,
                ),
                onPressed: rightAction,
              ),
            ],
          ),
        )
      ],
      backgroundColor: ThemUntil().mainColor(context),
      elevation: 0,
      brightness: ThemUntil().stateBarColor(context),
    );
  }
}
