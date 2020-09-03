import 'package:flutter/material.dart';
import 'package:zhihudaily_flutter/state/them_model.dart';
import '../state/provider_store.dart';
class ThemUntil {
    static const String THEMSTATE = 'them_state';//主题模式

    ThemeData linghtData = ThemeData(

    );  //日间模式
   final ThemeData darktData = ThemeData(
      scaffoldBackgroundColor:Color(0xFF121212),
      textTheme: TextTheme(body1: TextStyle(color: Colors.white))
    );  //夜间模式

//主题背景颜色
  Color mainColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()?Colors.black:Color(0xFFF4F5F7);
  }
  //部分widget颜色
  Color widgetColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()?Color(0xFFF4F5F7):Colors.black;
  }
  //部分图标颜色
  Color iconColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()?Colors.grey:null;
  }

}