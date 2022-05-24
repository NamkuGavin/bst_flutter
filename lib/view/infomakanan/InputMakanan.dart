import 'package:bst/header/HeaderNavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputMakanan extends StatefulWidget {
  const InputMakanan({Key? key}) : super(key: key);

  @override
  State<InputMakanan> createState() => _InputMakananState();
}

class _InputMakananState extends State<InputMakanan> {
  String? dropdownValue;
  TextEditingController makananController = TextEditingController();
  TextEditingController porsiController = TextEditingController();

  Widget nutritionTable(Color color, String name, double gr) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: color),
      child: Row(
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
            gr.toString(),
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, color: Color(0xFF4CAF50)),
          ),
          Text(
            '\ngr',
            style:
                GoogleFonts.montserrat(color: Color(0xFFC4C4C4), fontSize: 10),
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
          title: HeaderNavigation(
            title: "",
          ),
        ),
        body: Container(
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
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: makananController,
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
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 173,
                    child: TextField(
                      controller: makananController,
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
                  Container(
                    padding: EdgeInsets.only(left: 18, top: 12, bottom: 12),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(25)),
                    width: 173,
                    child: Text('Makanan',
                        style: GoogleFonts.openSans(color: Colors.grey)),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                  height: 40,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black),
                      borderRadius: BorderRadius.circular(50)),
                  child: DropdownButton<String>(
                    iconSize: 20,
                    isExpanded: true,
                    hint: Text("Pilih waktu makan"),
                    value: dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFF99CB57)),
                    underline: SizedBox.shrink(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
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
                height: 26,
              ),
              Text(
                'Informasi Gizi',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4CAF50),
                    fontSize: 16),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('160',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF99CB57),
                              fontSize: 58,
                            )),
                        Text(
                          'Kalori',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF818181),
                              fontSize: 18),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        nutritionTable(
                            Colors.grey.shade200, 'Karbohidrat', 32.500),
                        nutritionTable(Colors.transparent, 'Lemak', 0.16),
                        nutritionTable(Colors.grey.shade200, 'Protein', 3.0009),
                        nutritionTable(Colors.transparent, 'Gula', 1.4),
                        nutritionTable(Colors.grey.shade200, 'Serat', 2.9)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/inputimage.png'))),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, right: 40),
                    width: 140,
                    height: 35,
                    child: ElevatedButton(
                        child: Text('UPGRADE NOW', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12),),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InputMakanan()));
                        },
                        style: ButtonStyle(
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF4CAF50)))),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
