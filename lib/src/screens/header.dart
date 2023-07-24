import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/bigtext.dart';
import '../../widgets/smalltext.dart';

Widget PageHeader(){
  return Column(
    children: [
      Container(
        child: Container(
          margin: EdgeInsets.only(top: 45, bottom: 15),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  BigText(text: "Pozdravljen",),
                  Row(
                    children: [
                      SmallText(text: "Blaz Smehov", color: Colors.black54,),
                      Icon(Icons.arrow_drop_down_rounded),
                    ],
                  ),
                ],
              ),
              Container(
                width: 45,
                height: 45,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}