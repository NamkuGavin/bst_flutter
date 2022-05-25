import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/FoodModel.dart';

class FoodItems extends StatefulWidget {
  final FoodModel model;
  FoodItems({Key? key, required this.model}) : super(key: key);

  @override
  State<FoodItems> createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                widget.model.getName,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700, color: Color(0xFF5C5C60)),
              ),
            ),
            Text(
              widget.model.getkal.toString(),
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
                  onPressed: () {},
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
          widget.model.getportion.toString() + ' Mangkok',
          style: GoogleFonts.openSans(),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          'K : ' +
              widget.model.getK.toString() +
              ' |  L : ' +
              widget.model.getL.toString() +
              '  |   P : ' +
              widget.model.getP.toString() +
              '   |   G : ' +
              widget.model.getG.toString() +
              '   |   S :  ' +
              widget.model.getS.toString() +
              '  ',
          style: GoogleFonts.openSans(fontSize: 13),
        ),
        SizedBox(
          height: 11,
        )
      ],
    );
  }
}
