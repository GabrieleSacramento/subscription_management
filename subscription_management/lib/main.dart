import 'package:flutter/material.dart';
import 'package:subscription_management/src/app.dart';
import 'package:subscription_management/src/setup/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerDependencies();

  runApp(App());
}
