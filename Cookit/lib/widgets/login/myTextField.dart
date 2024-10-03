import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.title, required this.enabled, required this.controller});

  final String title;
  final bool enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        showCursor: false,
        maxLines: 1,
        enabled: enabled,
        obscureText: title == 'mot de passe',
        enableSuggestions: title != 'mot de passe',
        autocorrect:  title != 'mot de passe',
        decoration: InputDecoration(
          hintText: title,
          hintStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              height: 23 / 100,
              color: const Color.fromRGBO(141, 154, 174, 0.50)
          ),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(
              color: Color(0xFFD80536),
              width: 3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(
              color: Color(0xFFD80536),
              width: 1,
            ),
          ),
        ),
        style: GoogleFonts.roboto(
        fontWeight: FontWeight.w800,
        fontSize: 20,
        height: 23 / 100,
        color: const Color(0xFF2B2E42)
      ),
      textAlign: TextAlign.center,
    );
  }
}

class MyTextFieldPositioned extends StatelessWidget {
  const MyTextFieldPositioned({super.key, required this.title,
    required this.topCoef, required this.enabled, required this.controller});

  final String title;
  final num topCoef;
  final bool enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width/2 - 350/2,
      top: MediaQuery.of(context).size.height * topCoef,
      width: 350,
      height: 56,
      child: SizedBox(
        width: 350,
        height: 56,
        child: MyTextField(title: title, enabled: enabled, controller: controller),
      ),
    );
  }
}
