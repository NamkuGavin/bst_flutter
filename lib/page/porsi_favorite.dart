import 'dart:convert';

import 'package:bst/model/TypeModel.dart';
import 'package:bst/page/list_makanan.dart';
import 'package:bst/view/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../header/HeaderNavigation.dart';
import '../model/FavoriteModel.dart';


class PorsiFavorite extends StatefulWidget {
  const PorsiFavorite({Key? key, required this.datumFavorite}) : super(key: key);
  final DatumFavorite datumFavorite;


  @override
  State<PorsiFavorite> createState() => _PorsiFavoriteState();
}

class _PorsiFavoriteState extends State<PorsiFavorite> {
  TextEditingController porsiControl = TextEditingController();
  bool _isLoading = false;

  Widget tableNutrisi(String name, String gr) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500, color: Color(0xFF818181)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            Text(
              gr + " gr",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, color: Color(0xFF4CAF50)),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );
  }

  save_MakananFavorite(DatumFavorite _favorite) async {
    final getUrl = "https://www.zeroone.co.id/bst/food.php";
    print(getUrl);
    Map<String, dynamic> data = {
      "apikey": "bstapp2022",
      "action": "add_food",
      "UserId": "1",
      "FoodID": _favorite.id,
      "RecordDate": DateFormat('yyyy-mm-dd').format(DateTime.now()).toString(),
      "Portion": porsiControl.text,
    };
    var dataUtf = utf8.encode(json.encode(data));
    var dataBase64 = base64.encode(dataUtf);
    final res = await http.post(
      Uri.parse(getUrl),
      body: {'data': dataBase64},
    );
    if (res.statusCode == 200) {
      setState(() {
        _isLoading = true;
      });
      jsonDecode(res.body);
      setState(() {
        _isLoading = false;
      });
    } else {
      Map<String, dynamic> body = jsonDecode(res.body);
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: body['message'],
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.datumFavorite.foodName,
                textAlign: TextAlign.start,
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                height: MediaQuery.of(context).size.height * 0.23,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tambah ke Jurnal",
                      style: GoogleFonts.montserrat(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: porsiControl,
                            style: TextStyle(fontSize: 15),
                            textCapitalization: TextCapitalization.sentences,
                            autocorrect: true,
                            enableSuggestions: true,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.only(left: 18, top: 12, bottom: 12),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Ubah Porsi',
                              hintStyle: GoogleFonts.openSans(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.5),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 0.5, color: Colors.black),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                widget.datumFavorite.uom,
                                style: GoogleFonts.openSans(color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: double.infinity,
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          widget.datumFavorite.foodType,
                          style: GoogleFonts.openSans(color: Colors.black),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                height: MediaQuery.of(context).size.height * 0.34,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Informasi Nutrisi",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kalori",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF818181)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          widget.datumFavorite.calories + " Kalori",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4CAF50)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    tableNutrisi("Karbo", widget.datumFavorite.carbohydrate),
                    tableNutrisi("Lemak", widget.datumFavorite.fat),
                    tableNutrisi("Protein", widget.datumFavorite.protein),
                    tableNutrisi("Gula", widget.datumFavorite.sugar),
                    tableNutrisi("Serat", widget.datumFavorite.fiber),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                margin: EdgeInsets.only(left: 275),
                child: ElevatedButton(
                    onPressed: () {
                      save_MakananFavorite(widget.datumFavorite);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF99CB57))),
                    child: Text(
                      'Simpan',
                      textAlign: TextAlign.center,
                    )),
              )
            ],
          ),
        ),
      ),
      appBar:  AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: HeaderNavigation(
          title: '',
        ),
      ),
    );
  }
}
