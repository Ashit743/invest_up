import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  runApp(GameWidget(
    game: mySprite()
    ));
}

class mySprite extends FlameGame{
  //Sprite Animation Component
  late SpriteAnimationComponent boyWalk;

  Future<void> onLoad() async {
    super.onLoad();
    print('load assets');

    final spriteSheet = await fromJSONAtlas('spriteAnimation.png', 'spriteAnimation.json');
    SpriteAnimation walk = SpriteAnimation.spriteList(spriteSheet, stepTime: .07);
    boyWalk = SpriteAnimationComponent()
    ..animation = walk
    ..position = Vector2(50, 150)
    ..size = Vector2(100,100);
    add(boyWalk);
  }

  void update(double dt){
    super.update(dt);
    boyWalk.x += dt * 50;
  }

}


