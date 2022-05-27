import 'package:bst/header/HeaderNavigation.dart';
import 'package:bst/model/FoodModel.dart';
import 'package:bst/reuse/FoodItems.dart';
import 'package:bst/view/infomakanan/InputMakanan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../reuse/MyRadioListTile.dart';

class InfoMakanan extends StatefulWidget {
  const InfoMakanan({Key? key}) : super(key: key);

  @override
  _InfoMakananState createState() => _InfoMakananState();
}

class _InfoMakananState extends State<InfoMakanan> {
  String? dropdownValue;
  String? dropdownValue1;
  int foodIndex = 0;
  bool isLoading = false;
  bool _showButton = false;
  InputMakanan? inputMakanan;
  List<FoodModel> firstPageList = [
    FoodModel('Bubur Ayam Spesial Plus Lengkap dengan Telor Puyuh', 430, 1, 3.2,
        1.2, 3.5, 2.2, 6.7),
    FoodModel('Bubur Ayam Spesial Plus Lengkap dengan Telor Puyuh', 202, 2, 3.2,
        1.2, 3.5, 2.2, 6.7),
    FoodModel('Bubur Ayam Spesial Plus Lengkap dengan Telor Puyuh', 221, 3, 3.2,
        1.2, 3.5, 2.2, 6.7),
    FoodModel('Bubur Ayam Spesial Plus Lengkap dengan Telor Puyuh', 301, 1, 3.2,
        1.2, 3.5, 2.2, 6.7),
    FoodModel('Bubur Ayam Spesial Plus Lengkap dengan Telor Puyuh', 220, 5, 3.2,
        1.2, 3.5, 2.2, 6.7),
    FoodModel('Bubur Ayam Spesial Plus Lengkap dengan Telor Puyuh', 100, 3, 3.2,
        1.2, 3.5, 2.2, 6.7),
  ];
  int pageIndicator = 0;
  TextEditingController controller = TextEditingController();

  Future _refresh() async {
    setState(() {
      isLoading = true;
      firstPageList.clear();
      Future.delayed(Duration(seconds: 2), () {
        addData();
        isLoading = false;
      });
    });
  }

  void addData() {
    setState(() {
      for (int i = firstPageList.length; i < 5; i++) {
        firstPageList.add(FoodModel(
            'Bubur Ayam Spesial Plus Lengkap dengan Telor Puyuh',
            100,
            2,
            3.2,
            1.2,
            3.5,
            2.2,
            6.7));
      }
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

  Widget foodItem(FoodModel model, int index) {
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
                model.getName,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700, color: Color(0xFF5C5C60)),
              ),
            ),
            Text(
              model.getkal.toString(),
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700, fontSize: 12),
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
                      _showButton = true;
                      foodIndex = index;
                    });
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF99CB57))),
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
          model.getportion.toString() + ' Mangkok',
          style: GoogleFonts.openSans(),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          'K : ' +
              model.getK.toString() +
              ' |  L : ' +
              model.getL.toString() +
              '  |   P : ' +
              model.getP.toString() +
              '   |   G : ' +
              model.getG.toString() +
              '   |   S :  ' +
              model.getS.toString() +
              '  ',
          style: GoogleFonts.openSans(fontSize: 13),
        ),
        SizedBox(
          height: 11,
        )
      ],
    );
  }

  Widget firstPage() {
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
                iconSize: 20,
                isExpanded: true,
                hint: Text("Pilih Kategori makanan"),
                value: dropdownValue,
                icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFF99CB57)),
                underline: SizedBox.shrink(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Makanan Indonesia',
                  'Makanan Eropa / America',
                  'Makanan Asia'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          lineSeparator(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
            child: RefreshIndicator(
                onRefresh: _refresh,
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemBuilder: ((context, index) {
                          return foodItem(
                            firstPageList[index],
                            index,
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) {
                          return lineSeparator();
                        },
                        itemCount: firstPageList.length)),
          ),
        ],
      ),
    );
  }

  Widget secondPage() {
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
                iconSize: 20,
                isExpanded: true,
                hint: Text("Pilih waktu makan"),
                value: dropdownValue1,
                icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFF99CB57)),
                underline: SizedBox.shrink(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue1 = newValue!;
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          lineSeparator(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.separated(
                        itemBuilder: ((context, index) {
                          return foodItem(
                            firstPageList[index],
                            index,
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) {
                          return lineSeparator();
                        },
                        itemCount: firstPageList.length),
                  ),
          ),
        ],
      ),
    );
  }

  Widget thirdPage() {
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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.separated(
                        itemBuilder: ((context, index) {
                          return foodItem(
                            firstPageList[index],
                            index,
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) {
                          return lineSeparator();
                        },
                        itemCount: firstPageList.length),
                  ),
          ),
        ],
      ),
    );
  }

  Widget addFood(FoodModel model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
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
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text('Bubur Ayam Spesial Plus',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF5C5C60))),
                ),
                Text(
                  model.getkal.toString(),
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700, fontSize: 12),
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
                          _showButton = false;
                        });
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF99CB57))),
                      child: Text(
                        '-',
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            width: 280,
            child: ElevatedButton(
              child: Text('TAMBAH MENU MAKANAN'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputMakanan(
                              model: firstPageList[foodIndex],
                            )));
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF99CB57))),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: HeaderNavigation(title: ""),
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
                    groupValue: pageIndicator,
                    leading: 'Pilihan \n Makanan',
                    // title: Text('One'),
                    onChanged: (value) => setState(() {
                      pageIndicator = value;
                    }),
                  ),
                  MyRadioListTile<int>(
                    value: 2,
                    groupValue: pageIndicator,
                    leading: 'Makanan \n Terakhir',
                    // title: Text('Two'),
                    onChanged: (value) => setState(() {
                      pageIndicator = value;
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
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  pageIndicator == 1
                      ? firstPage()
                      : pageIndicator == 2
                          ? secondPage()
                          : pageIndicator == 3
                              ? thirdPage()
                              : Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 180),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/mainlogo.png'))),
                                  ),
                                ),
                  _showButton ? addFood(firstPageList[foodIndex]) : Container()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
