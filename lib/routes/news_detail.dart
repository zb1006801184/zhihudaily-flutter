import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';
import 'package:zhihudaily_flutter/unitls/them_util.dart';
import '../widgets/news_detail_bottom.dart';

class NewsDetail extends StatefulWidget {
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebView web;
  bool complete = false;
  String url;
  @override
  void initState() {
    super.initState();
  }
//分享
    shareClick() {
      Share.share(url);
    }
  @override
  Widget build(BuildContext context) {
     url = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: Container(
      height: Global.ksHeight,
      width: Global.ksWidth,
      child: Stack(
        children: [
          _buildWebView(url),
          _buildBlankWidget(),
          _buildBottomWidget(),
        ],
      ),
    ));
  }

  Widget _buildWebView(String url) {
    return Container(
      child: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onPageFinished: (String url) {
          setState(() {
            complete = true;
          });
        },
      ),
    );
  }

  Widget _buildBlankWidget() {
    if (complete) {
      return Container();
    }
    String title;
    complete == false ? title = "加载中。。。" : title = "";
    return Positioned(
        left: 0,
        top: 0,
        child: Container(
          height: Global.ksHeight,
          width: Global.ksWidth,
          decoration: BoxDecoration(
            color:
                complete ? Colors.transparent : ThemUntil().webBGColor(context),
          ),
          child: Center(
            child: Text(title),
          ),
        ));
  }

  Widget _buildBottomWidget() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: NewDetailBottom(
          newCollect: false,
          newLike: false,
          shareClick: shareClick,
        ));
  }
}
