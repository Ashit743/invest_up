import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:invest_up/authentication/signin_page.dart';
import 'package:invest_up/spite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //FIREBASE init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(MaterialApp(
      home: SignInPage(),
    debugShowCheckedModeBanner: false,
  ));
}
