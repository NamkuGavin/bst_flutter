import 'dart:convert';

import 'package:bst/header/HeaderNavigation.dart';
import 'package:bst/model/CategoryModel.dart';
import 'package:bst/model/FavoriteModel.dart';
import 'package:bst/model/TypeModel.dart';

import 'package:bst/view/infomakanan/PorsiMakanan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../model/FoodModel.dart';
import '../reuse/MyRadioListTile.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? idxUom;
  String? dropdownCategory;
  List? categoryList;
  String? dropdownType;
  List? typeList;
  String? dropdownUom;
  List? uomList;
  String? dropdownTambahMenu;
  String? dropdownUbahWaktu;
  bool porsiPageMakanan = false;
  bool mainPageShown = true;
  bool listPageShown = false;
  bool inputPageShown = false;
  bool _isLoading = false;
  bool _requiredFilter = false;
  CategoryModel? firstPageList;
  TypeModel? secondPageList;
  FavoriteModel? thirdPageList;
  List<DatumCategory> itemsCategory = [];
  List<DatumFavorite> itemsFavorite = [];
  List<DatumType> itemsType = [];
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
  TextEditingController controller = TextEditingController();
  int pageIndicator = 0;
  int foodIndex = 0;
  List<FoodModel> dropdownItems = [
    FoodModel('Bubur Ayam Spesial Plus Lengkap dengan Telor Puyuh', 430, 1, 3.2,
        1.2, 3.5, 2.2, 6.7),
    FoodModel('Sate Maranggi', 202, 2, 3.2, 1.2, 3.5, 2.2, 6.7),
    FoodModel('Sate Kambing', 221, 3, 3.2, 1.2, 3.5, 2.2, 6.7),
    FoodModel('Sop Betawi', 301, 1, 3.2, 1.2, 3.5, 2.2, 6.7),
    FoodModel('Capcay', 220, 5, 3.2, 1.2, 3.5, 2.2, 6.7),
    FoodModel('Udeh', 100, 3, 3.2, 1.2, 3.5, 2.2, 6.7),
    FoodModel('Udang tepung', 100, 3, 3.2, 1.2, 3.5, 2.2, 6.7),
    FoodModel('Mi Goreng', 100, 3, 3.2, 1.2, 3.5, 2.2, 6.7),
  ];

  getList_PilihanMakanan() async {
    final getUrl = "https://www.zeroone.co.id/bst/food.php";
    print(getUrl);
    Map<String, dynamic> data = {
      "apikey": "bstapp2022",
      "action": "list_food_by_category",
      "FoodCategory": dropdownCategory,
      "UserId": "1",
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
      firstPageList = CategoryModel.fromJson(json.decode(res.body.toString()));
      itemsCategory = firstPageList!.data;
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

  getList_TypeMakanan() async {
    final getUrl = "https://www.zeroone.co.id/bst/food.php";
    print(getUrl);
    Map<String, dynamic> data = {
      "apikey": "bstapp2022",
      "action": "list_food_by_type",
      "FoodType": dropdownType,
      "UserId": "1",
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
      secondPageList = TypeModel.fromJson(json.decode(res.body.toString()));
      itemsType = secondPageList!.data;
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

  getList_FavoriteMakanan() async {
    final getUrl = "https://www.zeroone.co.id/bst/food.php";
    print(getUrl);
    Map<String, dynamic> data = {
      "apikey": "bstapp2022",
      "action": "list_food_by_favorite",
      "UserId": "1",
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
      thirdPageList = FavoriteModel.fromJson(json.decode(res.body.toString()));
      itemsFavorite = thirdPageList!.data;
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

  saveList_PilihanMakanan() async {
    final getUrl = "https://www.zeroone.co.id/bst/food.php";
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

  Future _refreshFirstPage() async {
    setState(() {
      _isLoading = true;
      Future.delayed(Duration(seconds: 2), () {
        getList_PilihanMakanan();
        _isLoading = false;
      });
    });
  }

  Future _refreshSecondPage() async {
    setState(() {
      _isLoading = true;
      Future.delayed(Duration(seconds: 2), () {
        getList_TypeMakanan();
        _isLoading = false;
      });
    });
  }

  Future _refreshThirdPage() async {
    setState(() {
      _isLoading = true;
      Future.delayed(Duration(seconds: 2), () {
        getList_FavoriteMakanan();
        _isLoading = false;
      });
    });
  }

  Future<String> getCategory() async {
    Map<String, dynamic> body = {
      "action": "list_food_category",
      "apikey": "bstapp2022",
    };
    var dataUtf = utf8.encode(json.encode(body));
    var dataBase64 = base64.encode(dataUtf);
    String url = "https://www.zeroone.co.id/bst/food.php";
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
    String url = "https://www.zeroone.co.id/bst/food.php";
    var res = await http.post(Uri.parse(url), body: {'data': dataBase64});
    var resBody = json.decode(res.body);
    setState(() {
      typeList = resBody['Data'];
    });
    print(resBody);
    return "Success";
  }

  Future<String> getUom() async {
    Map<String, dynamic> body = {
      "apikey": "bstapp2022",
      "action": "list_uom",
    };
    var dataUtf = utf8.encode(json.encode(body));
    var dataBase64 = base64.encode(dataUtf);
    String url = "https://www.zeroone.co.id/bst/food.php";
    var res = await http.post(Uri.parse(url), body: {'data': dataBase64});
    var resBody = json.decode(res.body);
    setState(() {
      uomList = resBody['Data'];
    });
    print(resBody);
    return "Success";
  }

  void initState() {
    _requiredFilter = true;
    getList_FavoriteMakanan();
    getType();
    getCategory();
    getUom();
    mainPageShown = true;
    porsiPageMakanan = false;
    inputPageShown = false;
    listPageShown = false;
  }

  Widget inputFoodPage() {
    return Builder(builder: (context) {
      return SingleChildScrollView(
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
                        mainPageShown = true;
                        porsiPageMakanan = false;
                        inputPageShown = false;
                        listPageShown = false;
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
      );
    });
  }

  Widget karbohidratFill() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.grey.shade200),
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
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: karbohidratController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelStyle: TextStyle(fontSize: 14),
                hintStyle: TextStyle(fontSize: 14),
                suffixStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 10),
                suffixText: 'gr',
                prefixText: "Karbohidrat",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
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
      decoration: BoxDecoration(color: Colors.transparent),
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
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: lemakController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelStyle: TextStyle(fontSize: 14),
                hintStyle: TextStyle(fontSize: 14),
                suffixStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 10),
                suffixText: 'gr',
                prefixText: "Lemak",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
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
      decoration: BoxDecoration(color: Colors.grey.shade200),
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
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: proteinController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelStyle: TextStyle(fontSize: 14),
                hintStyle: TextStyle(fontSize: 14),
                suffixStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 10),
                suffixText: 'gr',
                prefixText: "Protein",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
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
      decoration: BoxDecoration(color: Colors.transparent),
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
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: sugarController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelStyle: TextStyle(fontSize: 14),
                hintStyle: TextStyle(fontSize: 14),
                suffixStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 10),
                suffixText: 'gr',
                prefixText: "Gula",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
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
      decoration: BoxDecoration(color: Colors.grey.shade200),
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
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: seratController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelStyle: TextStyle(fontSize: 14),
                hintStyle: TextStyle(fontSize: 14),
                suffixStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA8A8A8), fontSize: 10),
                suffixText: 'gr',
                prefixText: "Serat",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget foodListPage() {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Informasi Makanan",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4CAF50),
                    fontSize: 16),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyRadioListTile<int>(
                    value: 1,
                    groupValue: pageIndicator,
                    leading: 'Pilihan \n Makanan',
                    // title: Text('One'),
                    onChanged: (value) => setState(() {
                      pageIndicator = value;
                      _requiredFilter = true;
                      dropdownCategory = null;
                    }),
                  ),
                  MyRadioListTile<int>(
                    value: 2,
                    groupValue: pageIndicator,
                    leading: 'Makanan \n Terakhir',
                    // title: Text('Two'),
                    onChanged: (value) => setState(() {
                      pageIndicator = value;
                      _requiredFilter = true;
                      dropdownType = null;
                    }),
                  ),
                  MyRadioListTile<int>(
                    value: 3,
                    groupValue: pageIndicator,
                    leading: 'Makanan \n Favorit',
                    // title: Text('Three'),
                    onChanged: (value) => setState(() {
                      pageIndicator = value;
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              pageIndicator == 1
                  ? firstPage()
                  : pageIndicator == 2
                      ? secondPage()
                      : pageIndicator == 3
                          ? thirdPage()
                          : Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 180),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/mainlogo.png'))),
                              ),
                            ),
            ],
          ),
        ),
      );
    });
  }

  Widget lineSeparator() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 2.0;
        final dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }

  Widget firstPage() {
    return Builder(builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.724,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 15),
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Cari nama makanan...',
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black),
                    borderRadius: BorderRadius.circular(50)),
                child: DropdownButton<String>(
                  hint: Text(
                    "Pilih Kategori Makanan",
                    style: GoogleFonts.openSans(color: Colors.grey),
                  ),
                  isExpanded: true,
                  value: dropdownCategory,
                  iconSize: 20,
                  iconEnabledColor: Color(0xFF4CAF50),
                  icon: Icon(Icons.keyboard_arrow_down),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownCategory = newValue!;
                      _requiredFilter = false;
                      if (dropdownCategory != null) {
                        getList_PilihanMakanan();
                      } else {}
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            lineSeparator(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.43,
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _refreshFirstPage,
                      child: _requiredFilter
                          ? Center(child: Text("Masukkan kategori makanan"))
                          : ListView.separated(
                              itemBuilder: ((context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            itemsCategory[index].foodName,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF5C5C60)),
                                          ),
                                        ),
                                        Text(
                                          itemsCategory[index].calories,
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Kal',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Color(0xFF5C5C60)),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width: 28,
                                          height: 18,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  foodIndex = index;
                                                  mainPageShown = false;
                                                  inputPageShown = false;
                                                  porsiPageMakanan = true;
                                                  listPageShown = false;
                                                  porsiControl.text =
                                                      itemsCategory[index]
                                                          .portion;
                                                });
                                              },
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color(0xFF99CB57))),
                                              child: Text(
                                                '+',
                                                textAlign: TextAlign.center,
                                              )),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      itemsCategory[index].portion +
                                          " " +
                                          itemsCategory[index].uom,
                                      style: GoogleFonts.openSans(),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'K : ' +
                                          itemsCategory[index].carbohydrate +
                                          ' |  L : ' +
                                          itemsCategory[index].fat +
                                          '  |   P : ' +
                                          itemsCategory[index].protein +
                                          '   |   G : ' +
                                          itemsCategory[index].sugar +
                                          '   |   S :  ' +
                                          itemsCategory[index].fiber +
                                          '  ',
                                      style: GoogleFonts.openSans(fontSize: 13),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    )
                                  ],
                                );
                              }),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return lineSeparator();
                              },
                              itemCount: itemsCategory.length)),
            ),
            Container(
              height: 45,
              width: 280,
              child: ElevatedButton(
                child: Text('TAMBAH MENU MAKANAN'),
                onPressed: () {
                  setState(() {
                    mainPageShown = false;
                    porsiPageMakanan = false;
                    inputPageShown = true;
                    listPageShown = false;
                  });
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF99CB57))),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget secondPage() {
    return Builder(builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.724,
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black),
                    borderRadius: BorderRadius.circular(50)),
                child: DropdownButton<String>(
                  hint: Text(
                    "Pilih Waktu Makanan",
                    style: GoogleFonts.openSans(color: Colors.grey),
                  ),
                  isExpanded: true,
                  value: dropdownType,
                  iconSize: 20,
                  iconEnabledColor: Color(0xFF4CAF50),
                  icon: Icon(Icons.keyboard_arrow_down),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownType = newValue!;
                      _requiredFilter = false;
                      if (dropdownType != null) {
                        getList_TypeMakanan();
                      } else {}
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            lineSeparator(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _refreshSecondPage,
                      child: _requiredFilter
                          ? Center(child: Text("Masukkan type makanan"))
                          : ListView.separated(
                              itemBuilder: ((context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            itemsType[index].foodName,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF5C5C60)),
                                          ),
                                        ),
                                        Text(
                                          itemsType[index].calories,
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Kal',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Color(0xFF5C5C60)),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width: 28,
                                          height: 18,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  foodIndex = index;
                                                  mainPageShown = false;
                                                  inputPageShown = false;
                                                  porsiPageMakanan = true;
                                                  listPageShown = false;
                                                  porsiControl.text =
                                                      itemsType[index].portion;
                                                });
                                              },
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color(0xFF99CB57))),
                                              child: Text(
                                                '+',
                                                textAlign: TextAlign.center,
                                              )),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      itemsType[index].portion +
                                          " " +
                                          itemsType[index].uom,
                                      style: GoogleFonts.openSans(),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'K : ' +
                                          itemsType[index].carbohydrate +
                                          ' |  L : ' +
                                          itemsType[index].fat +
                                          '  |   P : ' +
                                          itemsType[index].protein +
                                          '   |   G : ' +
                                          itemsType[index].sugar +
                                          '   |   S :  ' +
                                          itemsType[index].fiber +
                                          '  ',
                                      style: GoogleFonts.openSans(fontSize: 13),
                                    ),
                                    SizedBox(
                                      height: 11,
                                    )
                                  ],
                                );
                              }),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return lineSeparator();
                              },
                              itemCount: itemsType.length),
                    ),
            ),
          ],
        ),
      );
    });
  }

  Widget thirdPage() {
    return Builder(builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.724,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 15),
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Cari nama makanan...',
                  hintStyle: GoogleFonts.openSans(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 0.5)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            lineSeparator(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _refreshThirdPage,
                      child: ListView.separated(
                          itemBuilder: ((context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        itemsFavorite[index].foodName,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF5C5C60)),
                                      ),
                                    ),
                                    Text(
                                      itemsFavorite[index].calories,
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Kal',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color(0xFF5C5C60)),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: 28,
                                      height: 18,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              foodIndex = index;
                                              mainPageShown = false;
                                              inputPageShown = false;
                                              porsiPageMakanan = true;
                                              listPageShown = false;
                                              porsiControl.text =
                                                  itemsFavorite[index].portion;
                                            });
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16))),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color(0xFF99CB57))),
                                          child: Text(
                                            '+',
                                            textAlign: TextAlign.center,
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  itemsFavorite[index].portion + ' Mangkok',
                                  style: GoogleFonts.openSans(),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'K : ' +
                                      itemsFavorite[index].carbohydrate +
                                      ' |  L : ' +
                                      itemsFavorite[index].fat +
                                      '  |   P : ' +
                                      itemsFavorite[index].protein +
                                      '   |   G : ' +
                                      itemsFavorite[index].sugar +
                                      '   |   S :  ' +
                                      itemsFavorite[index].fiber +
                                      '  ',
                                  style: GoogleFonts.openSans(fontSize: 13),
                                ),
                                SizedBox(
                                  height: 11,
                                )
                              ],
                            );
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return lineSeparator();
                          },
                          itemCount: itemsFavorite.length),
                    ),
            ),
          ],
        ),
      );
    });
  }

  Widget porsiMakanan() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "model.getName",
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
                    "Tambah makanan",
                    style: GoogleFonts.montserrat(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: porsiControl,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 18, top: 10, bottom: 12),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'Edit Porsi',
                      hintStyle: GoogleFonts.openSans(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        iconSize: 20,
                        isExpanded: true,
                        hint: Text("Ubah waktu"),
                        value: dropdownUbahWaktu,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: Color(0xFF99CB57)),
                        underline: SizedBox.shrink(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownUbahWaktu = newValue!;
                          });
                        },
                        items: <String>[
                          'Sarapan',
                          'Makan Siang',
                          'Makan Malam',
                          'Snack'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                    style: GoogleFonts.montserrat(),
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
                        "model.getkal.toString()" + " Kalori",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4CAF50)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  tableNutrisi("Karbo", 0),
                  tableNutrisi("Lemak", 0),
                  tableNutrisi("Protein", 0),
                  tableNutrisi("Gula", 0),
                  tableNutrisi("Serat", 0),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 275),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      mainPageShown = true;
                      porsiPageMakanan = false;
                      inputPageShown = false;
                      listPageShown = false;
                    });
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
    );
  }

  Widget tableNutrisi(String name, double gr) {
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
              gr.toString() + " gr",
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

  Widget mainPage() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            inputPageShown = false;
            mainPageShown = false;
            listPageShown = true;
          });
        },
        child: Text('Pindah'),
      ),
    );
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
        body: mainPageShown
            ? mainPage()
            : listPageShown
                ? foodListPage()
                : porsiPageMakanan
                    ? porsiMakanan()
                    : inputPageShown
                        ? inputFoodPage()
                        : Container());
  }
}
