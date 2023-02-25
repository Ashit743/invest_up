import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:invest_up/authentication/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:invest_up/screens/s1_dashboard.dart';

void main() async {
  //FIREBASE init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(MaterialApp(
      home: FirebaseAuth.instance.currentUser == null? SignInPage(): DashboardPage(),
    debugShowCheckedModeBanner: false,
  ));
}
