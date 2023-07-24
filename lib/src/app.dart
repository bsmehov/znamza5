import 'package:flutter/material.dart';
import 'package:znam_za_5_app/src/screens/createblog.dart';
import 'package:znam_za_5_app/src/screens/login.dart';
import 'package:znam_za_5_app/src/screens/Testni.dart';
import 'package:get/get.dart';
import 'package:znam_za_5_app/helper/dependencies.dart' as dep;

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login App",
      theme: ThemeData(
        accentColor: Colors.orange,
        primarySwatch: Colors.blue,
      ),
      home: Testni(),
    );
  }
}
