import 'dart:convert';

import 'package:bst/model/CheckModel.dart';
import 'package:bst/model/FacebookModel.dart';
import 'package:bst/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  CheckModel? _checkModel;
  String _check = "";
  bool _loadCheck = true;
  String _action = "";

  Future _checkLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString('type') == "1") {
        setState(() {
          _action = "google";
        });
      } else if (prefs.getString('type') == "2") {
        setState(() {
          _action = "facebook";
        });
      } else {
        setState(() {
          _action = "";
        });
      }
      Map<String, dynamic> body = {
        "apikey": "bstapp2022",
        "action": _action,
        "id_login": prefs.getString('id_login'),
        "parameter": prefs.getString('parameter'),
      };
      print("BODY: " + body.toString());
      final data = base64.encode(utf8.encode(jsonEncode(body)));
      final response =
          await http.post(Uri.parse(ServerConfig.newUrl + 'login.php'),
              body: (<String, String>{
                'data': data.toString(),
              }));
      print("DATA: " + response.body.toString());
      if (response.statusCode == 200) {
        _checkModel =
            CheckModel.fromJson(json.decode(response.body.toString()));
        _check = _checkModel!.response;
        return _check;
      } else {
        throw Exception(
            "Unable to reload data. Please check your internet connection.");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      return null;
    }
  }

  Future _loginGoogle() async {
    try {
      final String type = "1";
      final GoogleSignInAccount? account = await GoogleSignIn().signIn();

      if (account == null) {
        return;
      }

      print("account id : " + account.id);

      Map<String, dynamic> data = {
        "id": account.id,
        "name": account.displayName,
        "email": account.email,
        "type": type,
      };

      Navigator.pushNamed(context, '/registersocmed', arguments: data);

      GoogleSignIn().disconnect();
    } catch (e) {
      print(e.toString());
    } finally {
      return null;
    }
  }

  Future _loginFacebook() async {
    try {
      final String type = "2";
      final result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success) {
        final json = await FacebookAuth.instance.getUserData();
        print("facebook json : " + json.toString());

        FacebookModel model = FacebookModel.fromJson(json);

        Map<String, dynamic> data = {
          'id': model.id,
          'email': model.email,
          'name': model.name,
          'type': type,
        };

        Navigator.pushNamed(context, '/registersocmed', arguments: data);

        FacebookAuth.instance.logOut();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLogin();
    if (_check == "true") {
      setState(() {
        _loadCheck = false;
      });
      Navigator.pushNamed(context, '/pagerouteview');
    } else {
      setState(() {
        _loadCheck = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _loadCheck
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(50.0, 24.0, 50.0, 16.0),
                        height: MediaQuery.of(context).size.height * 3.7 / 7,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Balanzing Your Life with",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              Container(
                                child: Image.asset('assets/images/logo.png',
                                    width: 250),
                              ),
                              SizedBox(height: 25),
                              Text(
                                "Punya sahabat yang nemenin kamu sampai dapat berat badan ideal, untuk mencapai hasil diet optimal!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    height: 1.5),
                              ),
                              SizedBox(height: 25),
                              Text(
                                "#KawalSampaiIdeal",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: (MediaQuery.of(context).size.height * 3.3 / 7),
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 12,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: (MediaQuery.of(context).size.height *
                                  0.4 /
                                  6),
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () async {
                                  final value = await Navigator.pushNamed(
                                      context, '/onboarding');
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Daftar',
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                    ]),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xff818181)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height *
                                  0.4 /
                                  6),
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () async {
                                  final value = await Navigator.pushNamed(
                                      context, '/login');
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('MASUK',
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                            ),
                                          )),
                                    ]),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xff99CB57)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Divider(color: Color(0xFF818181))),
                                  SizedBox(width: 10),
                                  Text(
                                    'atau masuk melalui',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        color: Color(0xFF818181)),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Divider(color: Color(0xFF818181))),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height *
                                  0.4 /
                                  6),
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  // Register with Google still not work
                                  _loginGoogle();
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      SvgPicture.asset(
                                          'assets/icons/google.svg',
                                          height: 20,
                                          width: 20),
                                      Padding(
                                          padding: EdgeInsets.only(left: 21)),
                                      Text('Daftar dengan akun Google',
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              color: Color(0xff818181),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                    ]),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height *
                                  0.4 /
                                  6),
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  // Register with Facebook still not work
                                  _loginFacebook();
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      SvgPicture.asset(
                                          'assets/icons/facebook.svg',
                                          height: 20,
                                          width: 20),
                                      Padding(
                                          padding: EdgeInsets.only(left: 30)),
                                      Text('Daftar dengan akun Facebook',
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              color: Color(0xff818181),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                    ]),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                '© 2022 - Balanz Shape Transformation',
                                style: TextStyle(
                                    fontSize: 10.0, color: Color(0xFF818181)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
