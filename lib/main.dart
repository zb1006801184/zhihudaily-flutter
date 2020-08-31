import 'package:flutter/material.dart';
import './app.dart';
import './unitls/sp_util.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await SpUtil.getInstance();
  runApp(MyApp());
}
