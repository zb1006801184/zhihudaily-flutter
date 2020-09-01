import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';
import '../models/news_model.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebView web;
  bool complete = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String url = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: Container(
      height: Global.ksHeight,
      width: Global.ksWidth,
      child: Stack(
        children: [
          _buildWebView(url),
          _buildBlankWidget(),
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
    String title;
    complete == false ? title = "加载中。。。" : title = "";
    return Positioned(
        left: 0,
        top: 0,
        child: Container(
          height: Global.ksHeight,
          width: Global.ksWidth,
          child: Center(
            child: Text(title),
          ),
        ));
  }
}
