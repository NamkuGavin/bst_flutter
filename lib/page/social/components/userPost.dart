import 'dart:convert';

import 'package:bst/main.dart';
import 'package:bst/page/social/social.dart';
import 'package:bst/server.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class userPost extends StatefulWidget {
  const userPost({Key? key}) : super(key: key);

  @override
  State<userPost> createState() => _userPostState();
}

var encoded1 = "";
String content = "";
Future<Null> addPost(int userid) async {
  Map<String, dynamic> socbody = {
    "apikey": "bstapp2022",
    "action": "post",
    "UserId": userid,
    "Content": content
  };
  encoded1 = base64.encode(utf8.encode(json.encode(socbody)));
  final dbsoc = await http.post(
      Uri.parse(ServerConfig.newUrl + 'social.php'),
      body: {"data": encoded1});
  if (dbsoc.statusCode == 200) {
    Map<String, dynamic> dbsocresponse = json.decode(dbsoc.body);
    print(dbsocresponse);
    Fluttertoast.showToast(
      msg: "Post added!",
    );
  }
}

class _userPostState extends State<userPost> {
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
            )
          ],
        ),
        child: Column(children: [
          SizedBox(
            width: 350,
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(width: 0.5, color: Colors.grey),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 35,
                                        height: 35,
                                        child: Image.asset(
                                          'assets/images/ice cream.png',
                                        )),
                                    // image: NetworkImage(
                                    // snapshot.data.image_url),
                                    // ),
                                    // NetworkImage(users[index].image_url),
                                    SizedBox(width: 10),
                                    Container(
                                        width: 250,
                                        constraints:
                                            BoxConstraints(maxHeight: 60),
                                        child: SingleChildScrollView(
                                            child: TextFormField(
                                          controller: _controller,
                                          obscureText: false,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 10,
                                          validator: (value) {
                                            print(value);
                                            if (value!.isEmpty) {
                                              return 'Field must be filled';
                                            }
                                            return null;
                                          },
                                          onChanged: (newValue) {
                                            content = newValue;
                                            print(content);
                                          },
                                          decoration: InputDecoration.collapsed(
                                            hintText:
                                                "Hai Lydia, bagaimana harimu?",
                                          ),
                                        )))
                                  ]),
                            ]))),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                    minWidth: 30,
                    color: Color(0xFF99CB57),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                    onPressed: () {
                      Future<void> addPosttoDB() async {
                        if (content != "") {
                          await addPost(1);
                          await fetchPost(1);
                          setState(() {});
                        } else {
                          Fluttertoast.showToast(
                            msg: "Post belum terisi",
                          );
                        }
                      }

                      addPosttoDB();
                      _controller.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return social();
                          },
                        ),
                      ).then((_) => setState(() {}));
                      Navigator.pop(context);
                    },
                    child: Text("POST",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                                fontSize: 20))),
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}
