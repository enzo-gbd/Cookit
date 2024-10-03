import 'package:flutter/material.dart';
import '../../widgets/creation/myIngredientsQuote.dart';
import '../../widgets/creation/myBigTextField.dart';
import '../../widgets/login/signUp/previousButton.dart';
import '../../widgets/login/signUp/nextButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  final ingredientsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            const MyIngredientsQuote(),
            MyBigTextFieldPositioned(title: 'Notez les ici, séparées par des virgules (ex: choux de bruxelles, epinards, cabillaud, ...)', enabled: true, controller: ingredientsController),
            PreviousButton(title: 'Precedent', onPressed: () {Navigator.pop(context);}),
            NextButton(title: 'Suivant', onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('ingredients', ingredientsController.text);
              Navigator.pushNamed(context, '/creation/nutrition');
            }),
          ]
      ),
    );
  }
}