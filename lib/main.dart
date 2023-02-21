import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
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
  late SpriteAnimation idle;
  late SpriteAnimation walkforward;
  late SpriteAnimation runBoyrun;
  bool boyFlipped = false;  


  Future<void> onLoad() async {
    super.onLoad();
    print('load assets');

    final spriteSheet = await fromJSONAtlas('spriteAnimation.png', 'spriteAnimation.json');
    final spriteSheetIdle = await fromJSONAtlas('idle.png', 'idle.json');
    final spriteSheetRun = await fromJSONAtlas('run.png', 'run.json');
    walkforward = SpriteAnimation.spriteList(spriteSheet, stepTime: .07);
    idle = SpriteAnimation.spriteList(spriteSheetIdle, stepTime: .07);
    runBoyrun = SpriteAnimation.spriteList(spriteSheetRun, stepTime: 0.04);
    boyWalk = SpriteAnimationComponent()
    ..animation = walkforward
    ..position = Vector2(50, 200)
    ..size = Vector2(100,100)
    ..anchor = Anchor.center;
    add(boyWalk);
    
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
    knob: CircleComponent(radius: 30, paint: knobPaint),
    background: CircleComponent (radius: 50, paint: backgroundPaint),
    margin: const EdgeInsets.only (left: 680, bottom: 40),
    );
    add(joystick);
    
  }

  @override
  void update(double dt){
    super.update(dt);
    final Vector2 xpos = joystick.relativeDelta;
    xpos[1] =0;
    if( xpos[0]<0 && !boyFlipped ) {
      boyFlipped = true;
      boyWalk.flipHorizontallyAroundCenter();
      boyWalk.animation = walkforward;
    }
    else if ( xpos[0]>0 && boyFlipped ) {
      boyFlipped = false;
      boyWalk.flipHorizontallyAroundCenter();
      boyWalk.animation = walkforward;
    }
    if ( xpos[0]==0 ) {
      boyWalk.animation = idle;
    }
    else { 
      boyWalk.animation = walkforward;
    }

    if(xpos[0]>0.8 || xpos[0]<-0.8){
      boyWalk.animation = runBoyrun;
      boyWalk.position.add(xpos * 150 *dt);
    }
    else{
      boyWalk.position.add(xpos * 80 *dt);
    }

    
    print(xpos[0]);
     //dt = 1/60 its delta time
  }

}


