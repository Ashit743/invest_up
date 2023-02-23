import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

class mySprite extends FlameGame with HasDraggables {
  //Sprite Animation Component

  late SpriteAnimationComponent boyWalk;
  late final JoystickComponent joystick;
  late SpriteAnimation idle;
  late SpriteAnimation walkforward;
  late SpriteAnimation runBoyrun;
  late SpriteComponent background;
  bool boyFlipped = false;

  Future<void> onLoad() async {
    super.onLoad();
    print('load assets');

    Sprite backgroundSprite = await loadSprite('cityBackground.png');
    background = SpriteComponent()
      ..sprite = backgroundSprite
      ..size = Vector2(4096, 720)
      ..position = Vector2(0, -300);
    add(background);

    final spriteSheet = await fromJSONAtlas('walk.png', 'walk.json');
    // final spriteSheetIdle = await fromJSONAtlas('idle.png', 'idle.json');
    // final spriteSheetRun = await fromJSONAtlas('run.png', 'run.json');
    final spriteSheetRunNew = await fromJSONAtlas('Runner.png', 'Runner.json');
    final SpriteSheetIdleNew =
        await fromJSONAtlas('NewIdle.png', 'NewIdle.json');

    walkforward = SpriteAnimation.spriteList(spriteSheet, stepTime: .07);
    idle = SpriteAnimation.spriteList(SpriteSheetIdleNew, stepTime: .07);
    runBoyrun = SpriteAnimation.spriteList(spriteSheetRunNew, stepTime: 0.04);
    boyWalk = SpriteAnimationComponent()
      ..animation = walkforward
      ..position = Vector2(150, 230)
      ..size = Vector2(60, 100)
      ..debugMode = true
      ..anchor = Anchor.center;

    add(boyWalk);

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 680, bottom: 40),
    );
    add(joystick);

    camera.followComponent(boyWalk,
        worldBounds: Rect.fromLTRB(0, 0, background.size.x, background.size.y));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final Vector2 xpos = joystick.relativeDelta;
    xpos[1] = 0;
    if (xpos[0] < 0 && !boyFlipped) {
      boyFlipped = true;
      boyWalk.flipHorizontallyAroundCenter();
      boyWalk.animation = walkforward;
    } else if (xpos[0] > 0 && boyFlipped) {
      boyFlipped = false;
      boyWalk.flipHorizontallyAroundCenter();
      boyWalk.animation = walkforward;
    } //walk animation

    if (xpos[0] == 0) {
      boyWalk.animation = idle;
    } else {
      boyWalk.animation = walkforward;
    }

    bool moveLeft = xpos[0] < 0;
    bool moveRight = xpos[0] > 0;
    if ((moveLeft && boyWalk.x > 25) ||
        (moveRight && boyWalk.x < background.size.x - 25)) {
      if (xpos[0] > 0.8 || xpos[0] < -0.8) {
        boyWalk.animation = runBoyrun;
        boyWalk.position.add(xpos * 150 * dt);
      } else {
        boyWalk.position.add(xpos * 80 * dt);
      }
    }

    print(boyWalk.x);

    //dt = 1/60 its delta time
  }
}
