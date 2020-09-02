import 'package:flutter/material.dart';
import './app.dart';
import './unitls/sp_util.dart';
import 'state/provider_store.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
    runApp(Store.init(child: MyApp()));
}
