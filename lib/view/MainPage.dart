import 'package:bst/header/HeaderNavigation.dart';
import 'package:bst/view/infomakanan/InfoMakanan.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: HeaderNavigation(
          title: '',
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InfoMakanan()));
          },
          child: Text('Pindah'),
        ),
      ),
    );
  }
}
