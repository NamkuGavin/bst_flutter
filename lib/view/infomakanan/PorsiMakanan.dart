import 'package:bst/header/HeaderNavigation.dart';
import 'package:bst/view/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PorsiMakanan extends StatefulWidget {
  const PorsiMakanan({Key? key}) : super(key: key);

  @override
  State<PorsiMakanan> createState() => _PorsiMakananState();
}

class _PorsiMakananState extends State<PorsiMakanan> {
  String? dropdownValue1;

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
        body: tambahMakanan());
  }

  Widget tambahMakanan() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sate",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            height: 150,
            width: 340,
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
            child: isiMakanan(),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            height: 225,
            width: 340,
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
            child: infoNutrisi(),
          ),
          Container(
            margin: EdgeInsets.only(left: 255),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
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
    );
  }

  Widget isiMakanan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tambah makanan"),
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 12,
          ),
          textCapitalization: TextCapitalization.sentences,
          autocorrect: true,
          enableSuggestions: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 18, top: 10, bottom: 12),
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
        SizedBox(height: 20),
        Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButton<String>(
              iconSize: 20,
              isExpanded: true,
              hint: Text("Ubah waktu"),
              value: dropdownValue1,
              icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFF99CB57)),
              underline: SizedBox.shrink(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue1 = newValue!;
                });
              },
              items: <String>['Sarapan', 'Makan Siang', 'Makan Malam', 'Snack']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget infoNutrisi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Informasi Nutrisi"),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Kalori",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500, color: Color(0xFF818181)),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "38 Kalori",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, color: Color(0xFF4CAF50)),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        tableNutrisi("Karbo", 0.94),
        tableNutrisi("Lemak", 1.62),
        tableNutrisi("Protein", 5.01),
        tableNutrisi("Gula", 0.13),
        tableNutrisi("Serat", 0.2),
      ],
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
              width: 8,
            ),
            Text(
              gr.toString() + " gr",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, color: Color(0xFF4CAF50)),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}


