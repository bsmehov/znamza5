import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:znam_za_5_app/widgets/smalltext.dart';
import 'package:znam_za_5_app/widgets/smalltext2.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = 250;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty ? SmallText2(text: firstHalf):
      Column(
        children: [
          SmallText2(text: hiddenText? (firstHalf+"...") :
          (firstHalf + secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
                print(hiddenText);
              });
            },
            child: Row(
              children: [
                SmallText2(text: "Pokaži več", color: Colors.greenAccent,),
                Icon(Icons.arrow_drop_down, color: Colors.greenAccent,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
