import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRecipeText extends StatelessWidget {
  const MyRecipeText({super.key, required this.title, required this.topCoef});
  final String title;
  final num topCoef;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * topCoef,
      left: MediaQuery.of(context).size.width * 0.1,
      height: 800,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                color: const Color(0xFF8D9AAE),
                fontWeight: FontWeight.w800,
                fontSize: 20,
                height: 1
            )
        ),
      ),
    );
  }
}