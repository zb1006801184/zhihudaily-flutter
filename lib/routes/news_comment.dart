import 'package:flutter/material.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';
import 'package:zhihudaily_flutter/unitls/them_util.dart';
import '../unitls/nav_bar_config.dart';

class NewsComment extends StatefulWidget {
  @override
  _NewsCommentState createState() => _NewsCommentState();
}

class _NewsCommentState extends State<NewsComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBarConfig().configAppBar("1条评论", context),
        body: Column(
          children: [
            Container(
              height: 0.2,
              color: Color(0xFF999999),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _buildItemWidget(index);
              },
              itemCount: 1,
            )),
            _bottomCommentButton(),
          ],
        ));
  }

//list item
  Widget _buildItemWidget(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index == 0)
          Container(
            height: 40,
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "1条短评",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headImageIcon(),
              _expandedView(),
            ],
          ),
        ),
        Container(
          height: 0.2,
          color: Color(0xFF999999),
        ),
      ],
    );
  }

  Widget _headImageIcon() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 20, right: 8),
      height: 30,
      width: 30,
      child: Image.asset("images/mine_head.png"),
    );
  }

  Widget _expandedView() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  "一横",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 3),
          child: Text("所以鱼翅好吃嘛"),
        ),
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "09-04 11:34",
                  style: TextStyle(color: Color(0xff999999), fontSize: 12),
                ),
              ),
              Container(
                // width: 80,
                height: 20,
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    iconButtonWidget(
                        numString: '3', iconString: 'images/detail_like.png'),
                    iconButtonWidget(
                        left: 30, iconString: 'images/detail_comment.png'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget iconButtonWidget({String numString, String iconString, double left}) {
    return Container(
      margin: EdgeInsets.only(left: left ?? 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (numString != null)
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Text(
                numString ?? '',
                style: TextStyle(color: Color(0xFF999999), fontSize: 12),
              ),
            ),
          Container(
            width: 15,
            height: 15,
            child: Image(
              image: AssetImage(iconString),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomCommentButton() {
    return InkWell(
      child: Container(
        height: Global.ksBottomBar + 20,
        width: Global.ksWidth,
        color: ThemUntil().commentBottomColor(context),
        padding: EdgeInsets.only(left: 10, top: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Image.asset(
                    'images/mine_head.png',
                    height: 30,
                    width: 30,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text("说说你的看法..."),
                ),
              ],
            ),
          ],
        )),
        onTap: (){
          Navigator.of(context).pushNamed("/CommenWrite");
        },
    );
  }
}
