import 'package:flutter/material.dart';
import './routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '知乎日报',
      initialRoute: '/root',
      onGenerateRoute: onGenerateRoute,
      routes: routes,
      // debugShowCheckedModeBanner: true, //debug标识
      // theme: ThemeData(
      //   brightness: Brightness.dark,
      //   primaryColor: Colors.black,
      //   accentColor: Colors.cyan[600],
      // ),
    );
  }
}
