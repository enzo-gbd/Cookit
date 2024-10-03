import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinishButton extends StatelessWidget {
  const FinishButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width/2 - 388/2,
      top: MediaQuery.of(context).size.height * 643/932,
      width: 388,
      height: 84,
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
            "Revenir à l’écran de connexion",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w800,
                fontSize: 30,
                height: 1,
                color: Colors.white
            ),
            textAlign: TextAlign.center,
          )
      ),
    );
  }
}