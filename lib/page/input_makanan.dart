import 'dart:convert';

import 'package:bst/page/list_makanan.dart';
import 'package:bst/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../header/HeaderNavigation.dart';


class InputMakanan extends StatefulWidget {
  const InputMakanan({Key? key}) : super(key: key);

  @override
  State<InputMakanan> createState() => _InputMakananState();
}

class _InputMakananState extends State<InputMakanan> {
  String? dropdownUom;
  List? uomList;
  String? dropdownCategory;
  List? categoryList;
  bool _isLoading = false;
  String? dropdownType;
  List? typeList;
  bool _requiredFilter = false;
  TextEditingController foodnameController = TextEditingController();
  TextEditingController portionController = TextEditingController();
  TextEditingController uomController = TextEditingController();
  TextEditingController kaloriController = TextEditingController();
  TextEditingController karbohidratController = TextEditingController();
  TextEditingController lemakController = TextEditingController();
  TextEditingController sugarController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController seratController = TextEditingController();
  TextEditingController porsiControl = TextEditingController();

  Future<String> getUom() async {
    Map<String, dynamic> body = {
      "apikey": "bstapp2022",
      "action": "list_uom",
    };
    var dataUtf = utf8.encode(json.encode(body));
    var dataBase64 = base64.encode(dataUtf);
    String url = ServerConfig.newUrl + "food.php";
    var res = await http.post(Uri.parse(url), body: {'data': dataBase64});
    var resBody = json.decode(res.body);
    setState(() {
      uomList = resBody['Data'];
    });
    print(resBody);
    return "Success";
  }

  Future<String> getCategory() async {
    Map<String, dynamic> body = {
      "action": "list_food_category",
      "apikey": "bstapp2022",
    };
    var dataUtf = utf8.encode(json.encode(body));
    var dataBase64 = base64.encode(dataUtf);
    String url = ServerConfig.newUrl + "food.php";
    var res = await http.post(Uri.parse(url), body: {'data': dataBase64});
    var resBody = json.decode(res.body);
    setState(() {
      categoryList = resBody['Data'];
    });
    print(resBody);
    return "Success";
  }

  Future<String> getType() async {
    Map<String, dynamic> body = {
      "action": "list_food_type",
      "apikey": "bstapp2022",
    };
    var dataUtf = utf8.encode(json.encode(body));
    var dataBase64 = base64.encode(dataUtf);
    String url = ServerConfig.newUrl + "food.php";
    var res = await http.post(Uri.parse(url), body: {'data': dataBase64});
    var resBody = json.decode(res.body);
    setState(() {
      typeList = resBody['Data'];
    });
    print(resBody);
    return "Success";
  }


  Widget karbohidratFill() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                  fontSize: 16),
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: karbohidratController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelStyle: TextStyle(fontSize: 14),
                hintStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 14),
                suffixStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 10),
                suffixText: 'gr',
                hintText: 'Karbohidrat',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lemakFill() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                  fontSize: 16),
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: lemakController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelStyle: TextStyle(fontSize: 14),
                hintStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 14),
                suffixStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 10),
                suffixText: 'gr',
                hintText: 'Lemak',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget proteinFill() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: TextField(
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                  fontSize: 16),
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: proteinController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelStyle: TextStyle(fontSize: 14),
                hintStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 14),
                suffixStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 10),
                suffixText: 'gr',
                hintText: 'Protein',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gulaFill() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                  fontSize: 16),
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: sugarController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelStyle: TextStyle(fontSize: 14),
                hintStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 14),
                suffixStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 10),
                suffixText: 'gr',
                hintText: 'Gula',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget seratFill() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                  fontSize: 16),
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: seratController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelStyle: TextStyle(fontSize: 14),
                hintStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 14),
                suffixStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 10),
                suffixText: 'gr',
                hintText: 'Serat',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  saveList_PilihanMakanan() async {
    final getUrl = ServerConfig.newUrl + "food.php";
    print(getUrl);
    Map<String, dynamic> data = {
      "apikey": "bstapp2022",
      "action": "add_food",
      "UserId": "1",
      "FoodName": foodnameController.text,
      "Portion": portionController.text,
      "Uom": dropdownUom,
      "FoodCategory": dropdownCategory,
      "FoodType": dropdownType,
      "Calories": kaloriController.text,
      "Carbohydrate": karbohidratController.text,
      "Fat": lemakController.text,
      "Protein": proteinController.text,
      "Sugar": sugarController.text,
      "Fiber": seratController.text,
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getUom();
    getCategory();
    getType();
  }


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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Input Menu Makanan Baru',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4CAF50),
                    fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                width: double.infinity,
                child: TextField(
                  controller: foodnameController,
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
                    hintText: 'Choose your food',
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: portionController,
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
                        hintText: 'Porsi',
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
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: DropdownButton<String>(
                          hint: Text(
                            "Pilih Uom",
                            style: GoogleFonts.openSans(color: Colors.grey),
                          ),
                          isExpanded: true,
                          value: dropdownUom,
                          iconSize: 20,
                          iconEnabledColor: Color(0xFF4CAF50),
                          icon: Icon(Icons.keyboard_arrow_down),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownUom = newValue!;
                            });
                          },
                          isDense: true,
                          underline: SizedBox.shrink(),
                          items: uomList?.map((item) {
                            return DropdownMenuItem(
                              child: Text(
                                item['Name'],
                                style: GoogleFonts.openSans(
                                    color: Colors.black),
                              ),
                              value: item['id'].toString(),
                            );
                          }).toList() ??
                              [],
                        )),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black),
                      borderRadius: BorderRadius.circular(50)),
                  child: DropdownButton<String>(
                    hint: Text("Pilih kategori makan",
                        style: GoogleFonts.openSans(color: Colors.grey)),
                    isExpanded: true,
                    value: dropdownCategory,
                    iconSize: 20,
                    iconEnabledColor: Color(0xFF4CAF50),
                    icon: Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownCategory = newValue!;
                      });
                    },
                    isDense: true,
                    underline: SizedBox.shrink(),
                    items: categoryList?.map((item) {
                      return DropdownMenuItem(
                        child: Text(
                          item['Name'],
                          style: GoogleFonts.openSans(color: Colors.black),
                        ),
                        value: item['id'].toString(),
                      );
                    }).toList() ??
                        [],
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black),
                      borderRadius: BorderRadius.circular(50)),
                  child: DropdownButton<String>(
                    hint: Text("Pilih tipe waktu makan",
                        style: GoogleFonts.openSans(color: Colors.grey)),
                    isExpanded: true,
                    value: dropdownType,
                    iconSize: 20,
                    iconEnabledColor: Color(0xFF4CAF50),
                    icon: Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownType = newValue!;
                      });
                    },
                    isDense: true,
                    underline: SizedBox.shrink(),
                    items: typeList?.map((item) {
                      return DropdownMenuItem(
                        child: Text(
                          item['Name'],
                          style: GoogleFonts.openSans(color: Colors.black),
                        ),
                        value: item['id'].toString(),
                      );
                    }).toList() ??
                        [],
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                'Informasi Gizi',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4CAF50),
                    fontSize: 18),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.22,
                          child: TextField(
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4CAF50),
                                fontSize: 20),
                            textAlign: TextAlign.center,
                            controller: kaloriController,
                            autocorrect: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Kalori',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF818181),
                              fontSize: 25),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        karbohidratFill(),
                        lemakFill(),
                        proteinFill(),
                        gulaFill(),
                        seratFill(),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.240,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/inputimage.png'))),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, right: 60),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: ElevatedButton(
                        child: Text(
                          'UPGRADE NOW',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontSize: 12),
                        ),
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF4CAF50)))),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(
                      child: Text(
                        'TAMBAHKAN CATATAN MAKANAN',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(fontSize: 12),
                      ),
                      onPressed: () {
                        saveList_PilihanMakanan();
                        _requiredFilter = true;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ListMakanan(pageIndicator: 1,)));

                      },
                      style: ButtonStyle(
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF99CB57)))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
