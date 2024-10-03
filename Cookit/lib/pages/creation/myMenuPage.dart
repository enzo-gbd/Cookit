import 'package:flutter/material.dart';
import '../../widgets/creation/myCreatedQuote.dart';
import '../../widgets/login/myCenteredButton.dart';
import 'recipePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyMenuPage extends StatefulWidget {
  const MyMenuPage({super.key, required this.meals});
  final Map<dynamic, dynamic> meals;

  @override
  _MyMenuPageState createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {
  late Map<dynamic, dynamic> meals;
  late List<List<String>> favorite = [];

  @override
  void initState() {
    super.initState();
    meals = widget.meals;
  }

  Future<void> addFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < favorite.length; i++) {
      final response = await http.post(
        Uri.parse('http://localhost:8000/favorites/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${prefs.getString('token')}'
        },
        body: jsonEncode({
          'user': prefs.getInt('id'),
          'dish_name': favorite[i][0],
          'parts_number': prefs.getString('peopleNumber'),
          'calories': favorite[i][1],
          'recipe': 'recipe',
          'ingredients': 'ingredients',
        }),
      );
      if (response.statusCode == 201) {
        print('${favorite[i][0]} added to favorites');
      } else {
        throw Exception('Failed to add ${favorite[i][0]} to favorites with error ${response.body}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MyCreatedQuote(),
          Container(
            margin: const EdgeInsets.only(top: 300, bottom: 200),
            height: 420,
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipePage(recipe: meals[index][2])),
                      );
                    },
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!favorite.any((element) => element[0] == meals[index][0])) {
                              favorite.add([meals[index]![0], meals[index]![1]]);
                            } else {
                              favorite.removeWhere((element) => element[0] == meals[index][0] && element[1] == meals[index][1]);
                            }
                          });
                          print(favorite);
                        },
                        child: Image.asset(!favorite.any((element) => element[0] == meals[index][0]) ? 'assets/img/white_heart.png' : 'assets/img/lil_black_heart.png'),
                      ),
                      title: Text(meals[index]![0]),
                      subtitle: Text('${meals[index]![1]} KCal/portions'),
                    ),
                );
              },
            ),
          ),
          MyCenteredButton(title: 'Retour à l\'acceuil', onPressed: () {Navigator.popUntil(context, (route) => route.settings.name == '/creation'); addFavorite();}, topCoef: 800/932),
        ]
      ),
    );
  }
}