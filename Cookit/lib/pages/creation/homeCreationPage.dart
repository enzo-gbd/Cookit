import 'package:flutter/material.dart';
import '../../widgets/creation/myCheckboxes.dart';
import '../../widgets/creation/myDigitField.dart';
import '../../widgets/creation/myText.dart';
import '../../widgets/creation/myHello.dart';
import '../../widgets/myClickableImg.dart';
import '../../widgets/login/myCenteredButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCreationPage extends StatefulWidget {
  const HomeCreationPage({super.key});

  @override
  _HomeCreationPageState createState() => _HomeCreationPageState();
}

class _HomeCreationPageState extends State<HomeCreationPage> {
  final peopleNumberController = TextEditingController();
  final mealNumberController = TextEditingController();
  var user = {
    'first_name': '',
    'email': '',
  };

  Future<void> setUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user['first_name'] = prefs.getString('first_name') ?? '';
      user['email'] = prefs.getString('email') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    setUser();
  }

  Future<Map<String, String>> getUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('first_name') ?? '';
    final email = prefs.getString('email') ?? '';
    return {'name': name, 'email': email};
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('peopleNumber', peopleNumberController.text);
    prefs.setString('mealNumber', mealNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MyHello(username: user['first_name']!),
          MyDigitFieldPositioned(topCoef: 272/932, enabled: true, controller: peopleNumberController),
          const MyText(title: "Combien êtes vous à manger ?", topCoef: 295/932, leftCoef: 79/430),
          MyDigitFieldPositioned(topCoef: 372/932, enabled: true, controller: mealNumberController),
          const MyText(title: "Pour combien de repas ?", topCoef: 395/932, leftCoef: 79/430),
          const MyText(title: "Entrées", topCoef: 520/932, leftCoef: 26/430),
          const MyText(title: "Plats", topCoef: 520/932, leftCoef: 181/430),
          const MyText(title: "Desserts", topCoef: 520/932, leftCoef: 315/430),
          MyCheckboxes(),
          MyCenteredButton(title: "Commencer !", topCoef: 650/932, onPressed: () {_save(); Navigator.pushNamed(context, '/creation/allergies');}),
          MyClickableImg(onTap: () {
            Navigator.pushNamed(context, '/favorite');
          }, imgPath: 'assets/img/black_heart.png',topCoef: 850/932, leftCoef: 65/430),
          MyClickableImg(onTap: () {}, imgPath: 'assets/img/red_circle.png',topCoef: 850/932, leftCoef: 0),
          MyClickableImg(onTap: () {
            Navigator.pushNamed(context, '/profile');
          }, imgPath: 'assets/img/black_user.png',topCoef: 850/932, leftCoef: 313/430),
        ]
      ),
    );
  }
}