import 'dart:convert';

import 'package:bst/header/HeaderNavigation.dart';
import 'package:bst/page/workout/gymWO.dart';
import 'package:bst/page/workout/workoutWO.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class workout extends StatefulWidget {
  const workout({Key? key}) : super(key: key);

  @override
  _workoutState createState() => _workoutState();
}

// class Item {
//   Item({
//     required this.expandedValue,
//     required this.headerValue,
//     required this.timeValue,
//     this.isExpanded = false,
//   });

//   String expandedValue;
//   String headerValue;
//   String timeValue;
//   bool isExpanded;
// }

List<ExpandableController> controllerList = [
  ExpandableController(),
  ExpandableController(),
  ExpandableController()
];

int currentIndex = -1;

Map<String, dynamic> wohomebody = {
  "apikey": "bstapp2022",
  "action": "workout_header",
  "WorkoutType": 1
};

Map<String, dynamic> wogymbody = {
  "apikey": "bstapp2022",
  "action": "workout_header",
  "WorkoutType": 2
};

var encoded1 = "";
List woList = [];
Future<Null> fetchWorkout(int id) async {
  if (id == 1) {
    encoded1 = base64.encode(utf8.encode(json.encode(wohomebody)));
  } else {
    encoded1 = base64.encode(utf8.encode(json.encode(wogymbody)));
  }
  final dbwo = await http.post(
      Uri.parse('https://www.zeroone.co.id/bst/workout.php'),
      body: {"data": encoded1});
  if (dbwo.statusCode == 200) {
    Map<String, dynamic> dbworesponse = json.decode(dbwo.body);
    print(dbworesponse);
    woList = dbworesponse['Data'];
    // workout = jsonDecode(dbwo.body) as List;
    print(woList);
  } else {
    throw Exception('Failed to load workout');
  }
}

class _workoutState extends State<workout> {
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
        body: SafeArea(
            child: Column(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 120,
                      width: 350,
                      child: GestureDetector(
                        onTap: () {
                          Future<void> wofrDB() async {
                            await fetchWorkout(1);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return homeWO(homeDetail: woList);
                                },
                              ),
                            ).then((_) => setState(() {}));
                          }

                          wofrDB();
                        },
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.asset(
                            'assets/images/homeWO.png',
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Color(0xFF99CB57),
                          elevation: 5,
                          // margin: EdgeInsets.all(10),
                        ),
                        // Text("Home Workout"),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        height: 120,
                        width: 350,
                        child: GestureDetector(
                          onTap: () {
                            Future<void> wofrDB() async {
                              await fetchWorkout(2);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return gymWO(gymList: woList);
                                  },
                                ),
                              ).then((_) => setState(() {}));
                            }

                            wofrDB();
                          },
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.asset(
                              'assets/images/gymWO.png',
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Color(0xFF99CB57),
                            elevation: 5,
                            // margin: EdgeInsets.all(10),
                          ),
                        )
                        // Text("Home Workout"),
                        )),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 120,
                      width: 350,
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(
                          'assets/images/comingsoon.png',
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFF99CB57),
                        elevation: 5,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    // height: 350,
                    // width: 350,
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/images/ads.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ])
        ])));
  }
}

// Widget _buildTitle() {
//   return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               height: 120,
//               width: 350,
//               child: Card(
//                 semanticContainer: true,
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                 child: Image.asset(
//                   'assets/images/homeWO.png',
//                   fit: BoxFit.fill,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 color: Color(0xFF99CB57),
//                 elevation: 5,
//                 // margin: EdgeInsets.all(10),
//               ),
//               // Text("Home Workout"),
//             )),
//         SizedBox(
//           height: 20,
//         ),
//         Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               height: 120,
//               width: 350,
//               child: Card(
//                 semanticContainer: true,
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                 child: Image.asset(
//                   'assets/images/gymWO.png',
//                   fit: BoxFit.fill,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 color: Color(0xFF99CB57),
//                 elevation: 5,
//                 // margin: EdgeInsets.all(10),
//               ),
//               // Text("Home Workout"),
//             )),
//         SizedBox(
//           height: 20,
//         ),
//         Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               height: 120,
//               width: 350,
//               child: Card(
//                 semanticContainer: true,
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                 child: Image.asset(
//                   'assets/images/comingsoon.png',
//                   fit: BoxFit.fill,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 color: Color(0xFF99CB57),
//                 elevation: 5,
//                 // margin: EdgeInsets.all(10),
//               ),
//               // Text("Home Workout"),
//             ))
//       ]);
// }

// class Card1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ExpandableNotifier(
//         child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Container(
//               height: 300,
//               width: double.infinity,
//               child: Card(
//                 color: Color(0xFF99CB57),
//                 clipBehavior: Clip.antiAlias,
//                 child: Column(
//                   children: <Widget>[
//                     ScrollOnExpand(
//                       scrollOnExpand: true,
//                       scrollOnCollapse: false,
//                       child: ExpandablePanel(
//                         controller: controllerList[0],
//                         theme: const ExpandableThemeData(
//                           // hasIcon: false,
//                           iconColor: Colors.white,
//                           headerAlignment:
//                               ExpandablePanelHeaderAlignment.center,
//                           tapBodyToCollapse: true,
//                         ),
//                         header: InkWell(
//                           onTap: () {
//                             currentIndex = 0;
//                             for (int i = 0; i < controllerList.length; i++) {
//                               if (i == currentIndex) {
//                                 controllerList[i].expanded = true;
//                               } else {
//                                 controllerList[i].expanded = false;
//                               }
//                             }
//                           },
//                           child: Container(
//                             color: Color(0xFF99CB57),
//                             child: Stack(children: <Widget>[
//                               Image.asset('assets/images/homeWO.png',
//                                   fit: BoxFit.contain),
//                               // Center(child: Text("Home Workout")),
//                             ]),
//                           ),
//                         ),
//                         collapsed: Container(),
//                         expanded: Container(
//                           color: Colors.white,
//                           child: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Bill Date",
//                                         style: TextStyle(color: Colors.blue)),
//                                     Text("15/05/2020",
//                                         style: TextStyle(color: Colors.blue)),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.blue,
//                                   thickness: 2.0,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Adjustment",
//                                       style: TextStyle(color: Colors.blue),
//                                     ),
//                                     Text(".00",
//                                         style: TextStyle(color: Colors.blue)),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.blue,
//                                   thickness: 2.0,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Total due",
//                                         style: TextStyle(color: Colors.blue)),
//                                     Text("413.27",
//                                         style: TextStyle(color: Colors.blue)),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         builder: (_, collapsed, expanded) {
//                           return Expandable(
//                             collapsed: collapsed,
//                             expanded: expanded,
//                             theme: const ExpandableThemeData(crossFadePoint: 0),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )));
//   }
// }

// //   Widget _buildPanel() {
//     return ExpansionPanelList(
//       expansionCallback: (int index, bool isExpanded) {
//         setState(() {
//           _data[index].isExpanded = !isExpanded;
//         });
//       },
//       children: _data.map<ExpansionPanel>((Item item) {
//         return ExpansionPanel(
//           headerBuilder: (BuildContext context, bool isExpanded) {
//             return Container(
//               height: 100,
//               width: double.infinity,
//               child: Card(
//                 semanticContainer: true,
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                 child: Text("Home Workout"),
//                 // Image.asset(
//                 //   'assets/images/gym1.png',
//                 //   fit: BoxFit.fill,
//                 // ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 color: Color(0xFF99CB57),
//                 elevation: 5,
//                 // margin: EdgeInsets.all(10),
//               ),
//               // Text("Home Workout"),
//             );
//           },
//           body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 SvgPicture.asset('assets/icons/barbel.svg'),
//                 Spacer(),
//                 Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text("Low Impact Workout"),
//                       Text("Day 1 - 10"),
//                     ])
//               ],
//             ),
//           ),
//           isExpanded: item.isExpanded,
//         );
//       }).toList(),
//     );
//   }
// }
