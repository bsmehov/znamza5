import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'itemscreen.dart';

final Stream <QuerySnapshot> trgovinaStream = FirebaseFirestore.instance.collection('trgovina').snapshots();

Widget TrgovinaSearch(String name){
  return StreamBuilder(
      stream: trgovinaStream,
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasError){
          return Text('something went wrong');
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            if (name.isEmpty) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          ItemScreen(index: index,),));
                },
                child: ListTile(
                  title: Text(
                    snapshot.data.docs[index].get("itemName"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    snapshot.data.docs[index].get("itemPrice"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        snapshot.data.docs[index].get("imgUrl")
                    ),
                  ),
                ),
              );
            }
            if (snapshot.data.docs[index].get("itemName")
                .toString()
                .toLowerCase()
                .startsWith(name.toLowerCase())) {
              return ListTile(
                title: Text(
                  snapshot.data.docs[index].get("itemName"),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  snapshot.data.docs[index].get("itemPrice"),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      snapshot.data.docs[index].get("imgUrl")
                  ),
                ),
              );
            }
            return Container();
          }
        );
      },
    );
}
