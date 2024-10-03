import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: MediaQuery.of(context).size.width * 26/430,
      top: MediaQuery.of(context).size.height * 841/932,
      width: 145,
      height: 43,
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