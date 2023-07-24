import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:znam_za_5_app/src/app.dart';
import 'package:znam_za_5_app/src/services/crud.dart';
import 'package:image_picker/image_picker.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {

  late String authorName, title, desc;

  File? selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    final File? imagefile = File(image!.path);

    setState(() {
      selectedImage = imagefile;
    });
  }

  uploadBlog() async{
    if (selectedImage != null){

      setState(() {
        _isLoading = true;
      });

      // uploading image to firebase storage
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImages").child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();
      print("this is url ${downloadUrl}");

      Map<String, String> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "description": desc,
      };

      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("blog add"),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              uploadBlog();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.file_upload),
            ),
          )
        ],
      ),
      body: _isLoading ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ) :
      Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: selectedImage != null ? Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(selectedImage!,fit: BoxFit.cover,)
                )
              ) : Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.add_a_photo),
              ),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: "Author Name"),
                    onChanged: (val){
                      authorName = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Title"),
                    onChanged: (val){
                      title = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Desc"),
                    onChanged: (val){
                      desc = val;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
