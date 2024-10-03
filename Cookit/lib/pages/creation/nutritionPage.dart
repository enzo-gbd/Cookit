import 'package:flutter/material.dart';
import '../../widgets/creation/myNutritionQuote.dart';
import '../../widgets/creation/myBigTextField.dart';
import '../../widgets/login/signUp/previousButton.dart';
import '../../widgets/login/signUp/nextButton.dart';
import '../../widgets/creation/myText.dart';
import 'MyMenuPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String decodeUtf8(String text) {
  return text.replaceAllMapped(
    RegExp(r'\\u(\w{4})'),
        (Match m) => String.fromCharCode(int.parse(m.group(1)!, radix: 16)),
  );
}

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  final nutritionController = TextEditingController();
  bool _isLoading = false;

  void dump() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('name'));
    print(prefs.getString('email'));
    print(prefs.getString('peopleNumber'));
    print(prefs.getString('mealNumber'));
    print(prefs.getString('mealType'));
    print(prefs.getString('allergies'));
    print(prefs.getString('ingredients'));
    print(prefs.getString('nutrition'));
  }

  Future<void> getMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final peopleNumber = prefs.getString('peopleNumber') ?? '';
    final mealNumber = prefs.getString('mealNumber') ?? '';
    final mealType = prefs.getString('mealType') ?? '';
    final allergies = prefs.getString('allergies') ?? '';
    final ingredients = prefs.getString('ingredients') ?? '';
    final nutrition = prefs.getString('nutrition') ?? '';
    var meals = {};

    setState(() {
      _isLoading = true;
    });

    const url = 'http://localhost:8000/openai/';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${prefs.getString('token')}'
      },
      body: jsonEncode({
        'peopleNumber': peopleNumber,
        'mealNumber': mealNumber,
        'mealType': mealType,
        'allergies': allergies ?? "",
        'ingredients': ingredients ?? "",
        'nutrition': nutrition ?? "",
      }),
    );
    final responseBody = jsonDecode(response.body);
    var res = responseBody['meals'];
    for (var i = 0; i < res.length; i++) {
      var meal = decodeUtf8(res[i][0]);
      var recipe = decodeUtf8(res[i][2]);
      meals[i] = [meal, res[i][1], recipe];
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyMenuPage(meals: meals)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            const MyNutritionQuote(),
            !_isLoading ? MyBigTextFieldPositioned(title: 'Notez les ici, séparées par des virgules (ex:  sain, sans fer, protéiné, ...)', enabled: true, controller: nutritionController) : Container(),
            PreviousButton(title: 'Precedent', onPressed: () {Navigator.pop(context);}),
            NextButton(title: 'Créer !', onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('nutrition', nutritionController.text);
              getMeals();
            }),
            _isLoading ? const Center(child: CircularProgressIndicator()) : Container(),
            _isLoading ? Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                child: Container(
                width: MediaQuery.of(context).size.width,
                  child: const Text('Le chef prépare votre menu...', textAlign: TextAlign.center)
                )
            ) : Container(),
          ]
      ),
    );
  }
}