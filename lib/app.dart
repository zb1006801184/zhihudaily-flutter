import 'package:flutter/material.dart';
import 'package:zhihudaily_flutter/state/provider_store.dart';
import 'package:zhihudaily_flutter/unitls/them_util.dart';
import './routes.dart';
import 'state/them_model.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '知乎日报',
      initialRoute: '/root',
      onGenerateRoute: onGenerateRoute,
      routes: routes,
      themeMode: Store.value<ThemModel>(context).getThemeModel()?ThemeMode.dark : ThemeMode
                    .light,
      darkTheme: ThemUntil().darktData,
    );
  }
}
