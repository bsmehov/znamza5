import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:znam_za_5_app/src/screens/verify.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  late String _email, _password, _repassword;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Sign up"),),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left:20, right: 20, top: 20),
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.5),
                    )
                  ]
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    prefixIcon: Icon(Icons.email, color: Colors.black,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.5),
                        )
                      ]
                  ),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Enter your password",
                        prefixIcon: Icon(Icons.password, color: Colors.black,),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.5),
                        )
                      ]
                  ),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Re enter your password",
                        prefixIcon: Icon(Icons.password, color: Colors.black,),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                    ),
                    onChanged: (value) {
                      setState(() {
                        _repassword = value.trim();
                      });
                    },
                  ),
                ),
              ]
            ),
          ),
          SizedBox(height: h*0.01,),
          RaisedButton(
            child: Text("Sign up"),
            onPressed: (){
              if (_password == _repassword) {
                auth.createUserWithEmailAndPassword(
                    email: _email, password: _password).then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => VerifyScreen()));
                });
                Fluttertoast.showToast(msg: "password is ${_password}",
                toastLength: Toast.LENGTH_SHORT);
              }
              else {
                Fluttertoast.showToast(msg: "passwords do not match",
                    toastLength: Toast.LENGTH_SHORT);
              }
            }
          )
        ],
      ),
    );
  }
}
