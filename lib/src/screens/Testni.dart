import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:znam_za_5_app/src/screens/pagebody.dart';
import 'package:znam_za_5_app/src/screens/trgovinascreen.dart';

import 'header.dart';

class Testni extends StatefulWidget {
  const Testni({Key? key}) : super(key: key);

  @override
  State<Testni> createState() => _TestniState();
}

class _TestniState extends State<Testni> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[

    Expanded(child: SingleChildScrollView(
      child: PageBody(),)
    ),
    Expanded(child: TrgovinaScreen()
    ),
    Text(
      'CONTACT GFG',
    ),
    Text(
      'HAHAHAHA'
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            PageHeader(),
            _widgetOptions.elementAt(_selectedIndex),
          ]
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
            color: Colors.grey,),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store,
              color: Colors.grey,),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad,
              color: Colors.grey,),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
              color: Colors.grey,),
            label: "home",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
