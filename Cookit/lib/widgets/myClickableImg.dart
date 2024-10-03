import 'package:flutter/material.dart';

class MyClickableImg extends StatelessWidget {
  const MyClickableImg({super.key, required this.onTap, required this.imgPath, required this.topCoef, required this.leftCoef});

  final Function onTap;
  final String imgPath;
  final num topCoef;
  final num leftCoef;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * topCoef,
      left: leftCoef == 0 ? MediaQuery.of(context).size.width/2 - 27 : MediaQuery.of(context).size.width * leftCoef,
      child: GestureDetector(
        onTap: () {onTap();},
        child: Image.asset(imgPath),
        ),
      );
  }
}