import 'package:flutter/material.dart';
import '../../widgets/creation/myRecipeText.dart';
import '../../widgets/login/signUp/previousButton.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.recipe});
  final String recipe;

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late final String recipe;

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            MyRecipeText(title: recipe, topCoef: 0.2),
            PreviousButton(title: "Retour", onPressed: () { Navigator.pop(context); }),
          ]
      ),
    );
  }
}