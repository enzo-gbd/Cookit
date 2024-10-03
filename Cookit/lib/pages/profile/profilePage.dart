import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/profile/myTitle.dart';
import '../../widgets/login/myTextField.dart';
import '../../widgets/myClickableImg.dart';
import '../../widgets/login/myCenteredButton.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  var isModifying = false;

  Future<void> setProfile() async {
    final prefs = await SharedPreferences.getInstance();
    firstNameController.text = prefs.getString('first_name') ?? '';
    nameController.text = prefs.getString('last_name') ?? '';
    emailController.text = prefs.getString('email') ?? '';
    phoneController.text = prefs.getString('phone_number') ?? '';
  }

  Future<void> updateUser() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.put(
      Uri.parse('http://localhost:8000/users/update/${prefs.getInt('id')}/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ${prefs.getString('token')}',
      },
      body: jsonEncode({
        'first_name': firstNameController.text,
        'last_name': nameController.text,
        'email': emailController.text,
        'phone_number': phoneController.text
      }),
    );
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      await prefs.setString('first_name', res['first_name']);
      await prefs.setString('last_name', res['last_name']);
      await prefs.setString('email', res['email']);
      await prefs.setString('phone_number', res['phone_number']);
    } else {
      throw Exception('Failed to update user with error ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    setProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            const MyTitle(),
            MyTextFieldPositioned(title: 'prenom', topCoef: 324/932, enabled: isModifying, controller: firstNameController),
            MyTextFieldPositioned(title: 'nom', topCoef: 395/932, enabled: isModifying, controller: nameController),
            MyTextFieldPositioned(title: 'email', topCoef: 466/932, enabled: isModifying, controller: emailController),
            MyTextFieldPositioned(title: 'numéro de téléphone', topCoef: 537/932, enabled: isModifying, controller: phoneController),
            MyCenteredButton(onPressed: () {
              if (isModifying) {
                updateUser();
                setState(() {
                  isModifying = false;
                });
              } else {
                setState(() {
                  isModifying = true;
                });
              }
            }, title: isModifying ? 'valider' : 'modifier', topCoef: 700/932),
            MyClickableImg(onTap: () {
              Navigator.popAndPushNamed(context, '/favorite');
            }, imgPath: 'assets/img/black_heart.png',topCoef: 850/932, leftCoef: 65/430),
            MyClickableImg(onTap: () {
              Navigator.pop(context);
            }, imgPath: 'assets/img/red_circle.png',topCoef: 850/932, leftCoef: 0),
            MyClickableImg(onTap: () {}, imgPath: 'assets/img/black_user.png',topCoef: 850/932, leftCoef: 313/430),
          ]
      ),
    );
  }
}