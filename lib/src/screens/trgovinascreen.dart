import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:znam_za_5_app/src/screens/createitem.dart';
import 'package:znam_za_5_app/src/screens/itemscreen.dart';
import 'package:znam_za_5_app/src/screens/trgovinaSearch.dart';
import 'package:znam_za_5_app/widgets/bigtext.dart';

class TrgovinaScreen extends StatefulWidget {
  const TrgovinaScreen({Key? key}) : super(key: key);

  @override
  State<TrgovinaScreen> createState() => _TrgovinaScreenState();
}

class _TrgovinaScreenState extends State<TrgovinaScreen> {

  final Stream <QuerySnapshot> trgovinaStream = FirebaseFirestore.instance.collection('trgovina').snapshots();

  bool StanjeProdaja = false;

  Widget ItemSquare(String imgUrl, String itemName){
    return Container(
      height: 120,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          //Center(child: Text(itemName)),
        ],
      ),
    );
  }

  Widget Vrstica (String besedilo){
    return InkWell(
      onTap: (){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CreateItem()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BigText(text: besedilo, color: Colors.black, size: 17,),
          Icon(Icons.arrow_right),
        ],
      ),
    );
  }

  Widget Item(String stanje){
    return StreamBuilder(
      stream: trgovinaStream,
      builder: (context, AsyncSnapshot snapshot){
        if (snapshot.hasError) {
          return Text('something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            if (snapshot.data.docs[index].get(stanje) == "Ja"){
              StanjeProdaja = true;
            } else {
              StanjeProdaja = false;
            }
            return StanjeProdaja ? InkWell(
              onTap: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ItemScreen(index: index)));
              },
              child: ItemSquare(
                snapshot.data.docs[index].get("imgUrl"),
                snapshot.data.docs[index].get("itemName"),
              ),
            ) : Container();
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Vrstica("Najbolj prodajani izdelki: "),
            Container(
              height: 120,
              child: Item("itemProdaja"),
            ),
            SizedBox(height: 10,),
            Vrstica("Novi izdelki: "),
            Container(
              height: 120,
              child: Item("itemNovost"),
            ),
          ],
        ),
      )
    );
  }
}
