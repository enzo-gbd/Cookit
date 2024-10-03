import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * (100/932),
      height: 128,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          "Informations personnelles",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w800,
              fontSize: 55,
              height: 64 / 100,
              color: const Color(0xFFD80536)
          ),
        ),
      ),
    );
  }
}