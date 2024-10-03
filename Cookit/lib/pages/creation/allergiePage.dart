import 'package:flutter/material.dart';
import '../../widgets/creation/myAllergieQuote.dart';
import '../../widgets/creation/myBigTextField.dart';
import '../../widgets/login/signUp/previousButton.dart';
import '../../widgets/login/signUp/nextButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllergiePage extends StatefulWidget {
  const AllergiePage({super.key});

  @override
  _AllergiePageState createState() => _AllergiePageState();
}

class _AllergiePageState extends State<AllergiePage> {
  final allergieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MyAllergieQuote(),
          MyBigTextFieldPositioned(title: 'Notez les ici, séparées par des virgules (ex: arachides, gluten, ...)', enabled: true, controller: allergieController),
          PreviousButton(title: 'Annuler', onPressed: () {Navigator.pop(context);}),
          NextButton(title: 'Suivant', onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('allergies', allergieController.text);
            Navigator.pushNamed(context, '/creation/ingredients');
          }),
        ]
      ),
    );
  }
}