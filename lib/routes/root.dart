import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
        child: 
        Swiper(itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
            return Container(

            );
          },      
        )
      ),
    );
  }
}
