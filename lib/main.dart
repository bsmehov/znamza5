import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:znam_za_5_app/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}


