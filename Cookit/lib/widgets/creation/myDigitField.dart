import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDigitField extends StatelessWidget {
  const MyDigitField({super.key, required this.enabled, required this.controller});

  final bool enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        showCursor: false,
        maxLines: 1,
        enabled: enabled,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        maxLength: 1,
        decoration: InputDecoration(
          hintText: '0',
          hintStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w800,
              fontSize: 24,
              height: 28 / 100,
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
        fontSize: 24,
        height: 28 / 100,
        color: const Color(0xFF2B2E42)
      ),
      textAlign: TextAlign.center,
    );
  }
}

class MyDigitFieldPositioned extends StatelessWidget {
  const MyDigitFieldPositioned({super.key, required this.topCoef, required this.enabled, required this.controller});

  final num topCoef;
  final bool enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 11/430,
      top: MediaQuery.of(context).size.height * topCoef,
      width: 54,
      height: 108,
      child: MyDigitField(enabled: enabled, controller: controller),
    );
  }
}
