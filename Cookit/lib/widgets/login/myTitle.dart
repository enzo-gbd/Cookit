import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * (150/932),
      height: 117,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Cook",
                  style: GoogleFonts.roboto(
                      color: const Color(0xFFD80536),
                      fontWeight: FontWeight.w800,
                      fontSize: 100,
                      height: 117 / 100
                  )
              ),
              TextSpan(
                text: "it",
                style: GoogleFonts.roboto(
                    color: const Color(0xFF8D9AAE),
                    fontWeight: FontWeight.w800,
                    fontSize: 100,
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