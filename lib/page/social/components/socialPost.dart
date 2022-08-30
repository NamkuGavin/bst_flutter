import 'dart:convert';

import 'package:bst/main.dart';
import 'package:bst/page/social/components/commentPost.dart';
import 'package:bst/page/social/social.dart';
import 'package:bst/server.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class socialPost extends StatefulWidget {
  const socialPost({
    Key? key,
  }) : super(key: key);

  @override
  State<socialPost> createState() => _socialPostState();
}

var encoded1 = "";
List<bool> likeList = List.filled(postListdb.length, false, growable: true);

Future<Null> likePost(int userid, int socid) async {
  Map<String, dynamic> socbody = {
    "apikey": "bstapp2022",
    "action": "like",
    "UserId": userid,
    "SocialID": socid,
    "flag": 1
  };
  encoded1 = base64.encode(utf8.encode(json.encode(socbody)));
  final dbsoc = await http.post(
      Uri.parse(ServerConfig.newUrl + 'social.php'),
      body: {"data": encoded1});
  if (dbsoc.statusCode == 200) {
    Map<String, dynamic> dbsocresponse = json.decode(dbsoc.body);
    Fluttertoast.showToast(
      msg: "Post liked!",
    );
    print(dbsocresponse);
  } else {
    throw Exception('Failed to like social post');
  }
}

Future<Null> unlikePost(int userid, int socid) async {
  Map<String, dynamic> socbody = {
    "apikey": "bstapp2022",
    "action": "like",
    "UserId": userid,
    "SocialID": socid,
    "flag": 0
  };
  encoded1 = base64.encode(utf8.encode(json.encode(socbody)));
  final dbsoc = await http.post(
      Uri.parse(ServerConfig.newUrl + 'social.php'),
      body: {"data": encoded1});
  if (dbsoc.statusCode == 200) {
    Map<String, dynamic> dbsocresponse = json.decode(dbsoc.body);
    Fluttertoast.showToast(
      msg: "Post unliked!",
    );
    print(dbsocresponse);
  } else {
    throw Exception('Failed to unlike social post');
  }
}

class _socialPostState extends State<socialPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 370,
        height: MediaQuery.of(context).size.height / 1.75,
        child: Column(children: <Widget>[
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: postListdb.length,
                  itemBuilder: (BuildContext context, index) {
                    return Column(children: [
                      SizedBox(
                          width: 370,
                          height: 320,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      5.0, 5.0, 5.0, 0),
                                  child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        Container(
                                            height: 270.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                color: Colors.white),
                                            width: double.infinity,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15.0, 20.0, 15.0, 7.0),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              width: 50,
                                                              height: 50,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15.0),
                                                                child: Center(
                                                                  child: Container(
                                                                      child:
                                                                          // NetworkImage(users[index].image_url),
                                                                          Image.asset('assets/images/ice cream.png')),
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  SizedBox(
                                                                      width:
                                                                          50),
                                                                  Text(
                                                                    postListdb[
                                                                            index]
                                                                        [
                                                                        'Fullname'],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                            textStyle:
                                                                                TextStyle(
                                                                      color: Color(
                                                                          0xFF99CB57),
                                                                      fontSize:
                                                                          15,
                                                                    )),
                                                                    maxLines: 2,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    postListdb[index]
                                                                            [
                                                                            'CreatedAt'] +
                                                                        " | " +
                                                                        postListdb[index]['total_like']
                                                                            .toString() +
                                                                        " likes | " +
                                                                        postListdb[index]['DataComment']
                                                                            .length
                                                                            .toString() +
                                                                        " komentar",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts.openSans(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                Color(0xFF818181),
                                                                            fontWeight: FontWeight.normal)),
                                                                  ),
                                                                ])
                                                          ]),
                                                      SizedBox(height: 10),
                                                      Container(
                                                          height: 140,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15.0,
                                                                    right: 15),
                                                            child: Text(
                                                              postListdb[index]
                                                                  ['Content'],
                                                              maxLines: 10,
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                textStyle: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Color(
                                                                        0xFF818181),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            ),
                                                          )),
                                                      SizedBox(height: 20),
                                                      Container(
                                                          height: 20,
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                SizedBox(
                                                                    width: 20),
                                                                Container(
                                                                  height: 20,
                                                                  child:
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            print(likeList[index]);
                                                                            if (likeList[index] ==
                                                                                false) {
                                                                              likeList[index] = true;
                                                                              likePost(1, index);
                                                                            } else {
                                                                              likeList[index] = false;
                                                                              unlikePost(1, index);
                                                                            }
                                                                            Navigator
                                                                                .push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) {
                                                                                  return social();
                                                                                },
                                                                              ),
                                                                            ).then((_) =>
                                                                                setState(() {}));
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Icon(
                                                                                  Icons.thumb_up_alt_outlined,
                                                                                  color: Colors.grey,
                                                                                  size: 15.0,
                                                                                ),
                                                                                SizedBox(width: 5),
                                                                                Text(
                                                                                  "Like this",
                                                                                  textAlign: TextAlign.left,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF818181), fontFamily: 'Roboto'),
                                                                                  ),
                                                                                ),
                                                                              ])),
                                                                ),
                                                                SizedBox(
                                                                    width: 50),
                                                                Container(
                                                                  height: 20,
                                                                  child:
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator
                                                                                .push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) {
                                                                                  return commentPost(userid: 1, postid: index);
                                                                                },
                                                                              ),
                                                                            ).then((_) =>
                                                                                setState(() {}));
                                                                          },
                                                                          child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Icon(
                                                                                  Icons.message_outlined,
                                                                                  color: Colors.grey,
                                                                                  size: 15.0,
                                                                                ),
                                                                                SizedBox(width: 5),
                                                                                Text(
                                                                                  "Beri Komentar",
                                                                                  textAlign: TextAlign.left,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    textStyle: TextStyle(fontSize: 13, color: Color(0xFF818181), fontFamily: 'Roboto'),
                                                                                  ),
                                                                                ),
                                                                              ])),
                                                                )
                                                              ])),
                                                    ])))
                                      ]))
                            ],
                          ))
                    ]);
                  }))
        ]));
  }
}
