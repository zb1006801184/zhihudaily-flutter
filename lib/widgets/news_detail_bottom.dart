import 'package:flutter/material.dart';
import 'package:zhihudaily_flutter/routes/news_detail.dart';
import 'package:zhihudaily_flutter/state/provider_store.dart';
import 'package:zhihudaily_flutter/state/them_model.dart';
import 'package:zhihudaily_flutter/unitls/them_util.dart';
import '../unitls/global.dart';
import '../unitls/toast_view.dart';
class NewDetailBottom extends StatefulWidget {
  bool newLike = false;
  bool newCollect = false;
  NewDetailBottom({
    this.newLike,
    this.newCollect,
  });
  @override
  _NewDetailBottomState createState() => _NewDetailBottomState();
}

class _NewDetailBottomState extends State<NewDetailBottom> {
  //点击图片
  _iconClick(int index) {
    if (index == 0) {
      
    }
    if (index == 1) {
      ToastView(title: '点赞成功',).showMessage();
    }
    if (index == 2) {
      setState(() {
        widget.newCollect = !widget.newCollect;
      });
    }
    if (index == 3) {
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Global.ksBottomBar + 20,
        color: ThemUntil().mainColor(context),
        child: Column(
          children: [
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLeftWidget(),
                  _buildIconWithNumWidget(1,
                      nums: '58', icon: 'images/detail_like.png'),
                  _buildIconWithNumWidget(2,
                      icon: widget.newCollect ==false?'images/detail_uncollect.png':'images/detail_collect.png'),
                  _buildIconWithNumWidget(3,
                      right: 16, icon: 'images/detail_share.png'),
                ],
              ),
            ),
          ],
        ));
  }

//带数字的图标
  Widget _buildIconWithNumWidget(int index,
      {String icon, String nums, double right = 0}) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(right: right),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Image(
                image: AssetImage(icon),
                width: 20,
                height: 20,
                fit: BoxFit.fill,
                color: ThemUntil().widgetColor(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: Text(
                nums ?? '',
                style: TextStyle(fontSize: 10),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        _iconClick(index);
      },
    );
  }
//左侧的widget  (返回 线  评论数)

  Widget _buildLeftWidget() {
    return Container(
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios,color: ThemUntil().widgetColor(context),),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 25,
            width: 1,
            color: ThemUntil().widgetColor(context),
          ),
          _buildIconWithNumWidget(0,
              nums: '6', icon: 'images/detail_comment.png'),
        ],
      ),
    );
  }
}
