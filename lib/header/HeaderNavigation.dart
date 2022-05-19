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
    var widthSreen = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.only(top: 15, bottom: 10, right: 20),
        width: MediaQuery.of(context).size.width,
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
                  onTapDown: (TapDownDetails details) {},
                  child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ], shape: BoxShape.circle, color: Colors.green),
                      width: 30,
                      height: 30,
                      child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/profil.png',
                            width: 30,
                            height: 30,
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
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
      )),
    );
  }

  buildImageLogo() {
    var widthSreen = MediaQuery.of(context).size.width;
    double heighLogo = 40;
    if (widthSreen < 768) {
      heighLogo = 30;
    }
    return Image.asset('assets/images/mainlogo.png',
        fit: BoxFit.contain, height: heighLogo);
  }
}
