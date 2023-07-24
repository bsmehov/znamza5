import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:znam_za_5_app/src/screens/signup.dart';
import 'package:znam_za_5_app/src/screens/Testni.dart';
import 'package:znam_za_5_app/src/screens/verify.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Login'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email"
              ),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password"
              ),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                color: Theme.of(context).accentColor,
                  child: Text("Sign in"),
                  onPressed: (){
                    auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Testni()));
                    });
              }),
              RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text("Sign up"),
                  onPressed: (){
                    auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VerifyScreen()));
                    });

              })
            ],
          ),
          SizedBox(height: h*0.1,),
          RichText(text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'Sign up',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap = (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen()));
                }
              )
            ]
          ))
        ],
      ),
    );
  }
}
