import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  Flame.device.setLandscape();
  runApp(GameWidget(
    game: mySprite()
    ));
}


class mySprite extends FlameGame with HasDraggables {
  //Sprite Animation Component


  late SpriteAnimationComponent boyWalk;
  late final JoystickComponent joystick;


  Future<void> onLoad() async {
    super.onLoad();
    print('load assets');

    final spriteSheet = await fromJSONAtlas('spriteAnimation.png', 'spriteAnimation.json');
    SpriteAnimation walkforward = SpriteAnimation.spriteList(spriteSheet, stepTime: .07);
    boyWalk = SpriteAnimationComponent()
    ..animation = walkforward
    ..position = Vector2(50, 150)
    ..size = Vector2(100,100)
    ..anchor = Anchor.center;
    add(boyWalk);
    
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
    knob: CircleComponent(radius: 30, paint: knobPaint),
    background: CircleComponent (radius: 100, paint: backgroundPaint),
    margin: const EdgeInsets.only (left: 140, bottom: 40),
    );
    add(joystick);
    
  }

  void update(double dt){
    super.update(dt);
    final Vector2 xpos = joystick.relativeDelta;
    xpos[1] =0;
    boyWalk.position.add(xpos * 300 *dt); //dt = 1/60 its delta time
  }

}


