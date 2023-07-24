import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:znam_za_5_app/src/screens/appicon.dart';
import 'package:znam_za_5_app/src/services/crud.dart';
import 'package:znam_za_5_app/widgets/expandabletext.dart';

import '../../widgets/bigtext.dart';
import '../../widgets/smalltext.dart';
import 'createblog.dart';
import 'createitem.dart';

class ItemScreen extends StatelessWidget {

  final int index;
  ItemScreen({Key? key, required this.index}) : super(key: key);

  final Stream <QuerySnapshot> trgovinaStream = FirebaseFirestore.instance.collection('trgovina').snapshots();

  Widget TrgovinaList(){
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text('something went wrong');
          }
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return ItemTile(
            imgUrl: snapshot.data?.docs[index].get("imgUrl"),
            itemName: snapshot.data?.docs[index].get("itemName"),
            itemPrice: snapshot.data?.docs[index].get("itemPrice"),
            itemDesc: snapshot.data?.docs[index].get("itemDesc"),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                    ),
                    child: Image.network(
                      snapshot.data?.docs[index].get("imgUrl"),
                      fit: BoxFit.cover,
                    )
                  )
              ),
              Positioned(
                top: 45,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    AppIcon(icon: Icons.arrow_back_ios),
                  ],
                )
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 220,
                child: Container(
                  height: 500,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: snapshot.data?.docs[index].get("title"), color: Colors.black,),
                      SmallText(text: snapshot.data?.docs[index].get("description"), color: Colors.grey,),
                      SizedBox(height: 10,),
                      BigText(text: snapshot.data?.docs[index].get("authorName"), color: Colors.grey, size: 15,),
                      SizedBox(height: 10,),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableText(text: "hahahahahaahhahahahahaha"
                              "hahahahahahahahahahahahaahhahahaha"
                              "hahahahahahahahahahahahahahaahha"
                              "hahahahahahahahahahahahahahahahaha"
                              "ahhahahahahahahahahahahahahahahahaha"
                              "haahhahahahahahahahahahahahaha"
                              "hahahahahahhahahahahahahahahaha"
                              "hahahahahaahhahahahahahahahahahahahahahahahahaha"
                              "hahahahahaahhahahahahahahahahahahahahahahahahaha"
                              "hahahahahaahhahahahahahahahahahahahahahahahahaha"
                              "hahahahahaahhahahahahahahahahahahahahahahahahaha"
                              "hahahahahaahhahahahahahahahahahahahahahahahahaha"
                              "hahahahahaahhahahahahahahahahahahahahahahahahaha"
                              ""),
                          ),
                      ),
                    ],
                  ),
                )
              )
            ],
          );
        }
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.greenAccent,
              ),
              child: BigText(text: "prenesi PDF", color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {

  String imgUrl, itemName, itemPrice, itemDesc;
  ItemTile({required this.imgUrl, required this.itemName, required this.itemPrice, required this.itemDesc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(itemName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
          )),
          SizedBox(height: 20,),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(imgUrl,
              fit: BoxFit.cover,),
            ),
          ),
          SizedBox(height: 20,),
          Text(itemDesc),
          SizedBox(height: 20,),
          Text(itemPrice),
        ],
      ),
    );
  }
}


