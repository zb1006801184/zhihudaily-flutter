import 'package:flutter/material.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';
import 'package:zhihudaily_flutter/unitls/nav_bar_config.dart';
import 'package:zhihudaily_flutter/unitls/them_util.dart';
import 'package:zhihudaily_flutter/unitls/cache_unitls.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String cacheString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestData();
  }

  _requestData() async {
    String cache = await CacheUnitls().loadCache();

    setState(() {
      cacheString = cache;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar("设置", context),
      body: ListView(
        children: [
          _itemWidget(title: '清除缓存'),
          lineWidget(8),
          _itemWidget(title: '去好评'),
          lineWidget(2),
          _itemWidget(title: '去吐槽'),
          lineWidget(8),
          _itemWidget(title: '证照中心'),
          lineWidget(2),
          _itemWidget(title: '知乎协议'),
        ],
      ),
    );
  }

//line
  Widget lineWidget(double height) {
    return Container(
      height: height,
      width: Global.ksWidth,
    );
  }

//item widget
  Widget _itemWidget({String title}) {
    return InkWell(
      child: Container(
        height: 48,
        width: Global.ksWidth,
        color: ThemUntil().settingColor(context),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(title),
            ),
            title != '清除缓存'
                ? Icon(
                    Icons.keyboard_arrow_right,
                    color: ThemUntil().iconColor(context),
                  )
                : Text(cacheString ?? '0M')
          ],
        ),
      ),
      onTap: ()async{
        await CacheUnitls().clearCache();
        setState(() {
          cacheString = '0M';
        });
      },
    );
  }
}
