import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MailQuestion extends StatelessWidget {
  const MailQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * (100/932),
      height: 128,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
                TextSpan(
                    text: "Quel est votre",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFFD80536),
                        fontWeight: FontWeight.w800,
                        fontSize: 55,
                        height: 117 / 100
                    )
                ),
                TextSpan(
                    text: " adresse mail",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF8D9AAE),
                        fontWeight: FontWeight.w800,
                        fontSize: 55,
                        height: 117 / 100
                    )
                ),
                TextSpan(
                    text: " ?",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFFD80536),
                        fontWeight: FontWeight.w800,
                        fontSize: 55,
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