import 'dart:convert';

import 'package:bst/page/input_makanan.dart';
import 'package:bst/page/porsi_category.dart';
import 'package:bst/page/porsi_favorite.dart';
import 'package:bst/page/porsi_type.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../header/HeaderNavigation.dart';
import '../model/CategoryModel.dart';
import '../model/FavoriteModel.dart';
import '../model/TypeModel.dart';
import '../reuse/MyRadioListTile.dart';
import '../server.dart';

class ListMakanan extends StatefulWidget {
  ListMakanan({Key? key, this.pageIndicator = 0}) : super(key: key);
  int pageIndicator = 0;
  @override
  State<ListMakanan> createState() => _ListMakananState();
}

class _ListMakananState extends State<ListMakanan> {
  String? dropdownCategory;
  String? dropdownType;
  bool _requiredFilter = false;
  bool _isLoading = false;
  TextEditingController controller = TextEditingController();
  CategoryModel? firstPageList;
  List<DatumCategory> itemsCategory = [];
  List? categoryList;
  TypeModel? secondPageList;
  List<DatumType> itemsType = [];
  List? typeList;
  FavoriteModel? thirdPageList;
  List<DatumFavorite> itemsFavorite = [];
  List? uomList;
  int foodIndex = 0;

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

  getList_PilihanMakanan() async {
    final getUrl = ServerConfig.newUrl +  "food.php";
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
    final getUrl = ServerConfig.newUrl + "food.php";
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
    final getUrl = ServerConfig.newUrl + "food.php";
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
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PorsiCategory(
                                                                datumCategory:
                                                                    itemsCategory[
                                                                        foodIndex])));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InputMakanan()));
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
                                                foodIndex = index;
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PorsiType(
                                                                datumType:
                                                                    itemsType[
                                                                        foodIndex])));
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
                                            foodIndex = index;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PorsiFavorite(
                                                            datumFavorite:
                                                                itemsFavorite[
                                                                    foodIndex])));
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getType();
    getUom();
    getCategory();
    _requiredFilter = true;
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
                    groupValue: widget.pageIndicator,
                    leading: 'Pilihan \n Makanan',
                    // title: Text('One'),
                    onChanged: (value) => setState(() {
                      widget.pageIndicator = value;
                      _requiredFilter = true;
                      dropdownCategory = null;
                    }),
                  ),
                  MyRadioListTile<int>(
                    value: 2,
                    groupValue: widget.pageIndicator,
                    leading: 'Makanan \n Terakhir',
                    // title: Text('Two'),
                    onChanged: (value) => setState(() {
                      widget.pageIndicator = value;
                      _requiredFilter = true;
                      dropdownType = null;
                    }),
                  ),
                  MyRadioListTile<int>(
                    value: 3,
                    groupValue: widget.pageIndicator,
                    leading: 'Makanan \n Favorit',
                    // title: Text('Three'),
                    onChanged: (value) => setState(() {
                      widget.pageIndicator = value;
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              widget.pageIndicator == 1
                  ? firstPage()
                  : widget.pageIndicator == 2
                      ? secondPage()
                      : widget.pageIndicator == 3
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
      ),
    );
  }
}
