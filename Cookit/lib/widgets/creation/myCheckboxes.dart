import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCheckboxes extends StatefulWidget {
  @override
  _MyCheckboxesState createState() => _MyCheckboxesState();
}

class _MyCheckboxesState extends State<MyCheckboxes> {
  bool entree = false;
  bool plat = false;
  bool dessert = false;

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('mealType', entree ? 'entrees' : plat ? 'plats' : 'desserts');
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * (541/932),
      left: MediaQuery.of(context).size.width * (34/430),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: entree,
            side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 1.0, color: Color(0xFFD80536)),
            ),
            activeColor: const Color(0xFFD80536),
            onChanged: (bool? value) {
              setState(() {
                entree = value!;
                plat = false;
                dessert = false;
              });
              _save();
            },
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 99/430),
          Checkbox(
            value: plat,
            side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 1.0, color: Color(0xFFD80536)),
            ),
            activeColor: const Color(0xFFD80536),
            onChanged: (bool? value) {
              setState(() {
                entree = false;
                plat = value!;
                dessert = false;
              });
              _save();
            },
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 99/430),
          Checkbox(
            value: dessert,
            side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 1.0, color: Color(0xFFD80536)),
            ),
            activeColor: const Color(0xFFD80536),
            onChanged: (bool? value) {
              setState(() {
                entree = false;
                plat = false;
                dessert = value!;
              });
              _save();
            },
          ),
        ],
      ),
    );
  }
}