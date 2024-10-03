import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  const MyText({super.key, required this.title, required this.topCoef, required this.leftCoef});
  final String title;
  final num topCoef;
  final num leftCoef;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * topCoef,
      left: MediaQuery.of(context).size.width * leftCoef,
      height: 117,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          title,
          style: GoogleFonts.roboto(
            color: const Color(0xFF8D9AAE),
            fontWeight: FontWeight.w800,
            fontSize: 20,
            height: 23 / 100
          )
        ),
      ),
    );
  }
}