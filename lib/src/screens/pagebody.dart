import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:znam_za_5_app/utils/dimensons.dart';

import '../../widgets/bigtext.dart';
import '../../widgets/smalltext.dart';
import 'itemscreen.dart';

class PageBody extends StatefulWidget {
  const PageBody({Key? key}) : super(key: key);

  @override
  State<PageBody> createState() => _PageBodyState();
}
// hahahah
class _PageBodyState extends State<PageBody> {

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
  }

  final Stream <QuerySnapshot> blogsStream = FirebaseFirestore.instance.collection('blogs').snapshots();
  String? imgUrl1;
  String? title1;
  String? description1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          child: StreamBuilder(
              stream: blogsStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text('something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                }
                return PageView.builder(
                    controller: pageController,
                    itemCount: 5,
                    itemBuilder: (context, position) {
                      imgUrl1 = snapshot.data.docs[position].get("imgUrl");
                      title1 = snapshot.data.docs[position].get("title");
                      description1 = snapshot.data.docs[position].get("description");
                      return _buildPageItem(position, imgUrl1!, title1!, description1!);
                    }
                );
              }
          ),
        ),
        new DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(height: 30,),
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Row(
            children: [
              BigText(text: "Popular", color: Colors.black,),
              SizedBox(width: 10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: 10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "ostali članki", color: Colors.grey,),
              )
            ],
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text('something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.docs.length - 5,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                ItemScreen(index: index + 5,),));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white30,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(snapshot.data.docs[index+5].get("imgUrl"),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                )
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 100,
                                //width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: Column(
                                    children: [
                                      BigText(text: snapshot.data.docs[index+5].get("title")),
                                      SmallText(text: snapshot.data.docs[index+5].get("description"))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
        ),
      ],
    );
  }
  Widget _buildPageItem(int index, String imgUrl, String ime, String opis){
    Matrix4 matrix = new Matrix4.identity();
    if(index == _currPageValue.floor()){
      var currScale = 1 - (_currPageValue-index)*(1 - _scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor()-1){
      var currScale = 1 - (_currPageValue-index)*(1 - _scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  ItemScreen(index: index,),));
        },
        child: Stack(
          children: [
            Container(
              height: 220,
              margin: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(imgUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height/7.03,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Column(
                        children: [
                          BigText(
                            text: ime,
                          ),
                          SizedBox(height: 2,),
                          SmallText(
                            text: opis,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
