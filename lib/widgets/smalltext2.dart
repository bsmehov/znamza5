import 'package:flutter/material.dart';

class SmallText2 extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  SmallText2({Key? key, this.color = Colors.black,
    required this.text,
    this.size=12,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: size,
        height: height,
      ),
    );
  }
}