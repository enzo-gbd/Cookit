import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCenteredButton extends StatelessWidget {
  const MyCenteredButton({super.key, required this.title, required this.onPressed, required this.topCoef});

  final String title;
  final VoidCallback onPressed;
  final num topCoef;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width/2 - 350/2,
      top: MediaQuery.of(context).size.height * topCoef,
      width: 350,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD80536),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        ),
        child: Text(
          title,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              height: 23 / 100,
              color: Colors.white
          ),
        )
      ),
    );
  }
}