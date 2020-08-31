import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("知乎日报"),
      ),
      body: Container(
        height: 200,
        child: 
        Swiper(itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.red,
              child: Center(
                child: Text("${index}"),
              ),
            );
          },      
        )
      ),
    );
  }
}
