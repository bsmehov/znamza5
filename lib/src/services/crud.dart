import 'package:cloud_firestore/cloud_firestore.dart';

// class for realtime sending and reading data from storage

class CrudMethods{

  // to create new instance, call the instance getter on FirebaseFirestore
  // this allows you to interact with Firestore using the default Firebase app
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future <void> addData(blogData) async{

    firestore.collection("blogs").add(blogData).catchError((e){
      print(e);
    });
  }

  // get methods returns stream of data from firebase storage

  Future getData() async{
    return firestore.collection("blogs").snapshots();
  }

  Future getDataTrgovina() async{
    return firestore.collection("trgovina").snapshots();
  }

  Future <void> addDataTrgovina(blogData) async{

    firestore.collection("trgovina").add(blogData).catchError((e){
      print(e);
    });
  }

}