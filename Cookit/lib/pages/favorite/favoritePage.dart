import 'package:cookit/pages/creation/nutritionPage.dart';
import 'package:flutter/material.dart';
import '../../widgets/creation/myCreatedQuote.dart';
import '../../widgets/myClickableImg.dart';
import '../creation/homeCreationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late List<Map<String, dynamic>> _favorites = [];
  late List<int> _toDelete = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse('http://localhost:8000/favoritesUser/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${prefs.getString('token')}'
        },
        body: jsonEncode({
          'user_id': prefs.getInt('id'),
        })
    );
    if (response.statusCode == 200) {
      setState(() {
        _favorites = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        for (var i = 0; i < _favorites.length; i++) {
          _favorites[i]['dish_name'] = decodeUtf8(_favorites[i]['dish_name']);
        }
      });
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  Future<void> _deleteFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < _toDelete.length; i++) {
      final response = await http.delete(Uri.parse('http://localhost:8000/favorites/${_toDelete[i]}/'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Token ${prefs.getString('token')}'
          },
          body: jsonEncode({
            'user_id': prefs.getInt('id'),
          })
      );
      if (response.statusCode == 204) {
        print('Favorite deleted');
      } else {
        throw Exception('Failed to delete favorite');
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
                itemCount: _favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!_toDelete.contains(_favorites[index]['id'])) {
                            _toDelete.add(_favorites[index]['id']);
                          } else {
                            _toDelete.remove(_favorites[index]['id']);
                          }
                        });
                      },
                      child: Image.asset(_toDelete.contains(_favorites[index]['id']) ? 'assets/img/white_heart.png' : 'assets/img/lil_black_heart.png'),
                    ),
                    title: Text(_favorites[index]['dish_name']),
                    subtitle: Text('${_favorites[index]['calories']} KCal/portions'),
                  );
                },
              ),
            ),
            MyClickableImg(onTap: () {}, imgPath: 'assets/img/black_heart.png',topCoef: 850/932, leftCoef: 65/430),
            MyClickableImg(onTap: () {
              Navigator.pop(context);
              _deleteFavorites();
            }, imgPath: 'assets/img/red_circle.png',topCoef: 850/932, leftCoef: 0),
            MyClickableImg(onTap: () {
              Navigator.popAndPushNamed(context, '/profile');
              _deleteFavorites();
            }, imgPath: 'assets/img/black_user.png',topCoef: 850/932, leftCoef: 313/430),
          ]
      ),
    );
  }
}