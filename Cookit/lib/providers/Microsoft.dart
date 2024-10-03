import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

Future<UserCredential> signInWithMicrosoft() async {
  final microsoftProvider = MicrosoftAuthProvider();
  final UserCredential userCreds;
  if (kIsWeb) {
    userCreds = await FirebaseAuth.instance.signInWithPopup(microsoftProvider);
  } else {
    userCreds = await FirebaseAuth.instance.signInWithProvider(microsoftProvider);
  }
  return userCreds;
}