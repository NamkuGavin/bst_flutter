import 'package:bst/view/notifikasi/NotifPage.dart';
import 'package:flutter/material.dart';

class HeaderNavigation extends StatelessWidget {
  final String title;
  HeaderNavigation({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderNavigationView(
      title: title,
    );
  }
}

class HeaderNavigationView extends StatefulWidget {
  HeaderNavigationView({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  HeaderNavigationViewState createState() => HeaderNavigationViewState(title);
}

class HeaderNavigationViewState extends State<HeaderNavigationView> {
  final String title;

  HeaderNavigationViewState(this.title);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.white, // changes position of shadow
          ),
        ]),
        padding: EdgeInsets.only(top: 15, bottom: 10, right: 20),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildImageLogo(),
                buildTitle(),
                // IconButton(
                //   icon: Icon(
                //     Icons.notifications_none,
                //     color: Colors.black,
                //   ),
                //   onPressed: () {
                //     // do something
                //   },
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NotifPage()));
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/profil.png',
                            width: 20,
                            height: 20,
                          ))),
                )
              ],
            ),
          ],
        ));
  }

  buildTitle() {
    return Container(
      child: Center(
          child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
      )),
    );
  }

  buildImageLogo() {
    double heighLogo = 40;
    return Image.asset('assets/images/mainlogo.png',
        fit: BoxFit.contain, height: heighLogo);
  }
}
