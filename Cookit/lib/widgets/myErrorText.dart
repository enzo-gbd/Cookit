import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyErrorText extends StatelessWidget {
  const MyErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * (325/932),
      height: 117,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          "Votre adresse mail \nou votre mot de passe semblent incorects",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              height: 90 / 100,
              color: const Color(0xFFD80536)
          ),
        ),
      ),
    );
  }
}