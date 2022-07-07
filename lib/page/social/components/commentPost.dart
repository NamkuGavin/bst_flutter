import 'dart:convert';

import 'package:bst/main.dart';
import 'package:bst/page/social/social.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class commentPost extends StatefulWidget {
  const commentPost({
    Key? key,
    required this.userid,
    required this.postid,
  }) : super(key: key);
  final int userid, postid;

  @override
  State<commentPost> createState() => _commentPostState();
}

var encoded1 = "";
String comment = "";

Future<Null> addComment(int userid, int socialid) async {
  Map<String, dynamic> socbody = {
    "apikey": "bstapp2022",
    "action": "comment",
    "UserId": userid,
    "Comment": comment,
    "SocialID": socialid,
  };
  encoded1 = base64.encode(utf8.encode(json.encode(socbody)));
  final dbsoc = await http.post(
      Uri.parse('https://www.zeroone.co.id/bst/social.php'),
      body: {"data": encoded1});
  if (dbsoc.statusCode == 200) {
    Map<String, dynamic> dbsocresponse = json.decode(dbsoc.body);
    print(dbsocresponse);
    SnackBar(content: Text('Comment added!'));
  } else {
    throw Exception('Failed to add comment on post');
  }
}

class _commentPostState extends State<commentPost> {
  @override
  Widget build(BuildContext context) {
    print(widget.postid);
    List commentList = postListdb[widget.postid]['DataComment'];
    print(commentList);
    return Scaffold(
        body: Container(
            height: 350,
            width: double.infinity,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //Comment User
                  Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      width: 35,
                                      height: 35,
                                      child: Image.asset(
                                        'assets/images/ice cream.png',
                                      )),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 60,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: TextFormField(
                                          style: GoogleFonts.montserrat(),
                                          obscureText: false,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 3,
                                          validator: (value) {
                                            print(value);
                                            if (value!.isEmpty) {
                                              return 'Field must be filled';
                                            }
                                            return null;
                                          },
                                          onChanged: (newValue) {
                                            comment = newValue;
                                            print(comment);
                                          },
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Tulis Komentar...",
                                          ),
                                        )),
                                  )
                                ]),
                          ])),

                  //Comment list
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: commentList.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          width: 35,
                                          height: 35,
                                          child: Image.asset(
                                            'assets/images/ice cream.png',
                                          )),
                                      SizedBox(width: 10),
                                      Container(
                                        height: 70,
                                        width: 320,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Text(
                                                  commentList[index]
                                                      ['Fullname'],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Color(0xFF99CB57),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Text(
                                                  commentList[index]['Comment']
                                                      .replaceAll("\\'", "'"),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      )
                                    ],
                                  ),
                                ]));
                      })
                ]))));
  }
}
