import 'dart:ui';
import 'package:flame/components.dart';
import 'package:invest_up/spite.dart';

class DialogBox extends TextBoxComponent{
  final mySprite game;
  DialogBox({required String text, required this.game, required boyX}) : super(
    text: text,
    position: Vector2(boyX,300),
    boxConfig: TextBoxConfig(dismissDelay: 5.0,maxWidth: game.size.x*.5,timePerChar: 0.1)) 
    {
    anchor: Anchor.bottomRight;
    }



  @override
  void update(double dt){
    super.update(dt);
    if(finished){
      game.remove(this);
      print('dialog completed');
    }
    print('entered in dialog box');
  }




}