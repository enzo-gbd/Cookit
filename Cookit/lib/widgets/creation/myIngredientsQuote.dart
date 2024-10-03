import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyIngredientsQuote extends StatelessWidget {
  const MyIngredientsQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * (125/932),
      left : MediaQuery.of(context).size.width/2 - 170,
      width: 340,
      height: 141,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
                TextSpan(
                    text: "Avez vous des ",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFFD80536),
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        height: 117 / 100
                    )
                ),
                TextSpan(
                    text: "aliments ",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF8D9AAE),
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        height: 117 / 100
                    )
                ),
                TextSpan(
                    text: "que vous n'",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFFD80536),
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        height: 117 / 100
                    )
                ),
                TextSpan(
                    text: "aimez pas ",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF8D9AAE),
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        height: 117 / 100
                    )
                ),
                TextSpan(
                    text: "?",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFFD80536),
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        height: 117 / 100
                    )
                ),
              ]
          ),
        ),
      ),
    );
  }
}