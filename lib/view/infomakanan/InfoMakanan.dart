import 'package:bst/header/HeaderNavigation.dart';
import 'package:flutter/material.dart';

import '../../reuse/MyRadioListTile.dart';

class InfoMakanan extends StatefulWidget {
  const InfoMakanan({Key? key}) : super(key: key);

  @override
  _InfoMakananState createState() => _InfoMakananState();
}

class _InfoMakananState extends State<InfoMakanan> {
  int _valueavailablefunds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: HeaderNavigation(title: ""),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Informasi Makanan"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyRadioListTile<int>(
                  width: 80,
                  value: 1,
                  groupValue: _valueavailablefunds,
                  leading: '5.000.000',
                  // title: Text('One'),
                  onChanged: (value) => setState(() {
                    _valueavailablefunds = value;
                  }),
                ),
                SizedBox(
                  width: 10,
                ),
                MyRadioListTile<int>(
                  width: 80,
                  value: 2,
                  groupValue: _valueavailablefunds,
                  leading: '10.000.000',
                  // title: Text('Two'),
                  onChanged: (value) => setState(() {
                    _valueavailablefunds = value;
                  }),
                ),
                SizedBox(
                  width: 10,
                ),
                MyRadioListTile<int>(
                  width: 80,
                  value: 3,
                  groupValue: _valueavailablefunds,
                  leading: '20.000.000',
                  // title: Text('Three'),
                  onChanged: (value) => setState(() {
                    _valueavailablefunds = value;

                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
