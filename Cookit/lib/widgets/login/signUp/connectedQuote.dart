import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectedQuote extends StatelessWidget {
  const ConnectedQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * (270/932),
      height: 210,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
                TextSpan(
                    text: "Votre",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFFD80536),
                        fontWeight: FontWeight.w800,
                        fontSize: 60,
                        height: 117 / 100
                    )
                ),
                TextSpan(
                    text: " compte",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF8D9AAE),
                        fontWeight: FontWeight.w800,
                        fontSize: 60,
                        height: 117 / 100
                    )
                ),
                TextSpan(
                    text: " à bien été",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFFD80536),
                        fontWeight: FontWeight.w800,
                        fontSize: 60,
                        height: 117 / 100
                    )
                ),
                TextSpan(
                    text: " créé",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF8D9AAE),
                        fontWeight: FontWeight.w800,
                        fontSize: 60,
                        height: 117 / 100
                    )
                )
              ]
          ),
        ),
      ),
    );
  }
}