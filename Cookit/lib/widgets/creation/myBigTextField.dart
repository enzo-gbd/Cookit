import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBigTextField extends StatelessWidget {
  const MyBigTextField({super.key, required this.title, required this.enabled, required this.controller});

  final String title;
  final bool enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      showCursor: false,
      enabled: enabled,
      maxLines: 10,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w800,
            fontSize: 20,
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
          color: const Color(0xFF2B2E42)
      ),
    );
  }
}

class MyBigTextFieldPositioned extends StatelessWidget {
  const MyBigTextFieldPositioned({super.key, required this.title,
    required this.enabled, required this.controller});

  final String title;
  final bool enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width/2 - 309/2,
      top: MediaQuery.of(context).size.height * 350/932,
      width: 309,
      height: 267,
      child: SizedBox(
        width: 309,
        height: 267,
        child: MyBigTextField(title: title, enabled: enabled, controller: controller),
      ),
    );
  }
}
