import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHello extends StatelessWidget {
  const MyHello({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * (97/932),
      height: 47,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
                TextSpan(
                    text: "Bonjour ",
                    style: GoogleFonts.roboto(
                        color: const Color(0xFFD80536),
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        height: 47 / 100
                    )
                ),
                TextSpan(
                    text: username,
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF8D9AAE),
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        height: 47 / 100
                    )
                )
              ]
          ),
        ),
      ),
    );
  }
}