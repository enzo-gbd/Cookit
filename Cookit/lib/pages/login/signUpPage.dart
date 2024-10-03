import 'package:cookit/widgets/login/myTextField.dart';
import 'package:cookit/widgets/login/signUp/previousButton.dart';
import 'package:cookit/widgets/login/signUp/nextButton.dart';
import 'package:cookit/widgets/login/signUp/nameQuest.dart';
import 'package:cookit/widgets/login/signUp/mailQuest.dart';
import 'package:cookit/widgets/login/signUp/pwdQuest.dart';
import 'package:cookit/widgets/login/signUp/connectedQuote.dart';
import 'package:cookit/widgets/login/signUp/finishButton.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  num step = 1;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> register() async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/users/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
        'first_name': firstNameController.text,
        'last_name': nameController.text,
      }),
    );
    if (response.statusCode == 201) {
      print('Signed up');
      setState(() {
        step = 4;
      });
    } else {
      throw Exception('Failed to sign up');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            if (step == 1)
              const NameQuestion()
            else if (step == 2)
              const MailQuestion()
            else if (step == 3)
              const PwdQuestion()
            else
              const ConnectedQuote(),
            if (step < 4)
              MyTextFieldPositioned(title: "prénom", topCoef: 370/932, enabled: step < 2, controller: firstNameController),
            if (step < 4)
              MyTextFieldPositioned(title: "nom", topCoef: 441/932, enabled: step < 2, controller: nameController),
            if (step >= 2 && step < 4)
              MyTextFieldPositioned(title: "adresse mail", topCoef: 512/932, enabled: step != 3, controller: emailController),
            if (step == 3)
              MyTextFieldPositioned(title: "mot de passe", topCoef: 583/932, enabled: true, controller: passwordController),
            if (step == 3)
              MyTextFieldPositioned(title: "mot de passe", topCoef: 654/932, enabled: true, controller: _passwordController),
            if (step == 1)
              PreviousButton(title: "Annuler", onPressed: () { Navigator.pop(context); })
            else if (step != 4)
              PreviousButton(title: "Précédent", onPressed: () { setState(() {step -= 1;}); }),
            if (step == 3)
              NextButton(title: "S'inscrire", onPressed: () {
                if (passwordController.text != _passwordController.text) {
                  print("Passwords don't match");
                } else {
                  register();
                }
              })
            else if (step == 4)
              FinishButton(onPressed: () { Navigator.pop(context); })
            else
              NextButton(title: "Suivant", onPressed: () { setState(() {step += 1;}); }),
          ]
      ),
    );
  }
}