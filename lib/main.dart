import 'package:cats_app/app.dart';
import 'package:cats_app/src/config/app_config.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await initConfig();
  runApp(const MainApp());
}
