import 'package:flutter/material.dart';
import '../unitls/nav_bar_config.dart';
class NewsComment extends StatefulWidget {
  @override
  _NewsCommentState createState() => _NewsCommentState();
}

class _NewsCommentState extends State<NewsComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar("6条评论", context),
      body: Center(
        child: Text("data"),
      ),
    );
  }
}