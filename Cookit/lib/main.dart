import 'package:english_words/english_words.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login/signUpPage.dart';
import 'pages/creation/homeCreationPage.dart';
import 'pages/creation/allergiePage.dart';
import 'pages/creation/ingredientsPage.dart';
import 'pages/creation/nutritionPage.dart';
import 'pages/favorite/favoritePage.dart';
import 'pages/profile/profilePage.dart';
import 'widgets/login/myTitle.dart';
import 'widgets/login/myTextField.dart';
import 'widgets/login/myCenteredButton.dart';
import 'widgets/myErrortext.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/google.dart';
import 'providers/microsoft.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create: (context) => MyAppState(),
    child: MaterialApp(
      title: 'Cookit',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routes: {
        '/': (context) => const MyHomePage(),
        '/signup': (context) => const SignUpPage(),
        '/creation': (context) => const HomeCreationPage(),
        '/creation/allergies': (context) => const AllergiePage(),
        '/creation/ingredients': (context) => const IngredientsPage(),
        '/creation/nutrition': (context) => const NutritionPage(),
        '/favorite': (context) => FavoritePage(),
        '/profile': (context) => const ProfilePage(),
      },
    ),
  );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];

  void get_next() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isIncorrect = false;
  
  Future<void> saveUserPreferences(Map<String, dynamic> res) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', res['id']);
    await prefs.setString('email', res['email']);
    await prefs.setString('first_name', res['first_name']);
    await prefs.setString('last_name', res['last_name']);
    await prefs.setString('phone_number', res['phone_number'] ?? '');
    await prefs.setString('token', res['token']);
  }

  Future<void> login() async {
    const url = 'http://127.0.0.1:8000/login/';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      saveUserPreferences(responseBody);
      Navigator.pushNamed(context, '/creation');
    }
    else if (response.statusCode == 401) {
      final responseBody = jsonDecode(response.body);
      print(responseBody['error']);
      setState(() {
        _isIncorrect = true;
      });
    } else {
      print("error: ${response.statusCode}");
    }
  }

  Future<void> registerWithCreds(User creds) async {
    var displayName = creds.displayName!.split(' ');
    final response = await http.post(
      Uri.parse('http://localhost:8000/oauth/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': creds.email,
        'password': creds.uid,
        'first_name': displayName[0],
        'last_name': displayName[1],
      }),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      saveUserPreferences(responseBody);
      Navigator.pushNamed(context, '/creation');
    }
    else if (response.statusCode == 401) {
      final responseBody = jsonDecode(response.body);
      print(responseBody['error']);
    } else {
      print("error: ${response.statusCode}");
    }
  }

  Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  void initState() {
    super.initState();
    init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            const MyTitle(),
            if (_isIncorrect) const MyErrorText(),
            MyTextFieldPositioned(title: "adresse mail", topCoef: 378/932, enabled: true, controller: emailController),
            MyTextFieldPositioned(title: "mot de passe", topCoef: 461/932, enabled: true, controller: passwordController),
            MyCenteredButton(title: "Se connecter", onPressed: () async {login();}, topCoef: 580/932),
            MyCenteredButton(title: "Je n'ai pas de compte", onPressed: () { Navigator.pushNamed(context, '/signup'); }, topCoef: 650/932),
            MyCenteredButton(title: "Se connecter avec Google", onPressed: () async {
              UserCredential userCreds = await signInWithGoogle();
              registerWithCreds(userCreds.user!);
            }, topCoef: 760/932),
            MyCenteredButton(title: "Se connecter avec Microsoft", onPressed: () async {
              UserCredential userCreds = await signInWithMicrosoft();
              registerWithCreds(userCreds.user!);
            }, topCoef: 830/932),
          ]
      ),
    );
  }
}