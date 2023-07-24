import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:znam_za_5_app/src/screens/trgovinascreen.dart';
import 'package:znam_za_5_app/src/services/crud.dart';

class CreateItem extends StatefulWidget {
  const CreateItem({Key? key}) : super(key: key);

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {

  late String itemName, itemPrice, itemDesc, itemLink, itemNovost, itemProdaja, itemRazred;

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

  uploadItem() async{
    if (selectedImage != null){

      setState(() {
        _isLoading = true;
      });

      // uploading image to firebase storage
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("itemImages").child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();
      print("this is url ${downloadUrl}");

      Map<String, String> itemMap = {
        "imgUrl": downloadUrl,
        "itemName": itemName,
        "itemPrice": itemPrice,
        "itemDesc": itemDesc,
        "itemNovost": itemNovost,
        "itemProdaja": itemProdaja,
        "itemRazred": itemRazred,
      };

      crudMethods.addDataTrgovina(itemMap).then((result) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => TrgovinaScreen()));
      });
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("add item"),
        actions: [
          GestureDetector(
            onTap: (){
              uploadItem();
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
            SizedBox(height: 10),
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
                  child: Image.file(selectedImage!, fit: BoxFit.cover,),
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
                    decoration: InputDecoration(hintText: "item Name"),
                    onChanged: (val){
                      itemName = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "price"),
                    onChanged: (val){
                      itemPrice = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Desc"),
                    onChanged: (val){
                      itemDesc = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "item Prodaja"),
                    onChanged: (val){
                      itemProdaja = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "item Razred"),
                    onChanged: (val){
                      itemRazred = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "item Novost"),
                    onChanged: (val){
                      itemNovost = val;
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
