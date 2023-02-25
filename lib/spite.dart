import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:invest_up/actors/friends.dart';
import 'package:invest_up/actors/mainChar.dart';
import 'package:invest_up/dialog/dialog_box.dart';
import 'package:invest_up/screens/s1_dashboard.dart';
import 'package:tiled/tiled.dart';
import 'package:invest_up/actors/friends.dart';
import 'package:flame/geometry.dart';

class mySprite extends FlameGame with HasDraggables, HasCollisionDetection  {
  //Sprite Animation Component

  late Krishna boyWalk;
  late final JoystickComponent joystick;
  late SpriteAnimation idle;
  late SpriteAnimation walkforward;
  late SpriteAnimation runBoyrun;
  late double mapWidth;
  late double mapHeight;
  late DialogBox dialogBox;
  List<int> CharNames = [0,1,2,3,4,5,6,7,8,9];
  late var charDetails = new Map();
  late var dialog = new Map();
  List<String> Sentences = [
      "Hello I am Ramesh, Would you like to become rich like me? I hope you can only dream Hahaha... ha ..ha..ha....ha.......... ha ok I'll let you go, I think you didnt get my joke",
      "Hello, I am Shweta, would you like to increase your assets, invest in mutual funds play this game and I'll let you know about it ",
      "Hello I am Shrinidhi, would you like to play a game, the weather is in yellow region today, an average day in investment",
      "Hola I am Varun, how about a game the bar seems to be in green.. ",
      "Namaste, Would you like to be interested in a game perhaps?",
      "howdy, like to play a game?",
      "So lets calculate your result, ... umm so you have done well not bad it seems, Ramesh is going to the bank he is in a bit of tension as Adani stocks fell, he is in a bit of tension, although lets go through your result"
    ];
    int dialogCharCount = 0;
  late SpriteComponent gauge;



  bool boyFlipped = false;
  bool dialogFlagFirstTime = true;
  bool dialogFlagNextTime = true;

  BuildContext context;

  mySprite(BuildContext this.context){
    this.context = context;
  }

  Future<void> onLoad() async {
    super.onLoad();
    print('load assets');

    final homeMap = await TiledComponent.load('map.tmx',Vector2.all(16))
      ..position = Vector2(0, -300);
    
    add(homeMap);



    final obstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('Friends');
    for (final obj in obstacleGroup!.objects){
      
      print(obj.x);
    }

    mapWidth = homeMap.tileMap.map.width * 16.0;
    mapHeight = homeMap.tileMap.map.height * 16.0;

    List<TiledObject> friendObject = homeMap.tileMap.getLayer<ObjectGroup>('Friends')!.objects;
    print(friendObject);



    int count = 0;
    for(var friend in friendObject){
       charDetails[CharNames[count]] = [friend.x,friend.y,dialogFlagFirstTime,];
      count+=1;
      // add(Friend(friend));
    }
    print(charDetails);

    final spriteSheet = await fromJSONAtlas('walk.png', 'walk.json');
    final spriteSheetRunNew = await fromJSONAtlas('Runner.png', 'Runner.json');
    final SpriteSheetIdleNew =
        await fromJSONAtlas('NewIdle.png', 'NewIdle.json');

    walkforward = SpriteAnimation.spriteList(spriteSheet, stepTime: .07);
    idle = SpriteAnimation.spriteList(SpriteSheetIdleNew, stepTime: .07);
    runBoyrun = SpriteAnimation.spriteList(spriteSheetRunNew, stepTime: 0.04);
    boyWalk = Krishna()
      ..animation = walkforward
      ..position = Vector2(50, 250)
      ..size = Vector2(60, 100)
      ..anchor = Anchor.center;

    add(boyWalk);

    Sprite gaugeSprite = await loadSprite('red-guage.png');
    gauge = SpriteComponent()
      ..sprite = gaugeSprite
      ..size = Vector2(150, 120)
      ..position = Vector2(10, 280);
      positionType= PositionType.viewport;
    add(gauge);

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 680, bottom: 40),
    );
    add(joystick);

    camera.followComponent(boyWalk,
        worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));
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
        (moveRight && boyWalk.x < mapWidth - 25)) {
      if (xpos[0] > 0.8 || xpos[0] < -0.8) {
        boyWalk.animation = runBoyrun;
        boyWalk.position.add(xpos * 150 * dt);
      } else {
        boyWalk.position.add(xpos * 80 * dt);
      }
    }


    //dailog box based on condition;

    if(charDetails[dialogCharCount][2] && boyWalk.x>charDetails[dialogCharCount][0] && boyWalk.x<charDetails[dialogCharCount][0]+50){
        dialogBox = DialogBox(text: Sentences[dialogCharCount], game: this, boyX: boyWalk.x);
        add(dialogBox);

        print(Sentences[dialogCharCount]);
        charDetails[dialogCharCount][2] = false;
        if(dialogCharCount < charDetails.length-1){
          dialogCharCount+=1;
        }
        sleep(Duration(seconds:0));
        CoolAlert.show(
            context: context,
            type: CoolAlertType.info,
            text: "Lap-"+dialogCharCount.toString() ,
            onConfirmBtnTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashboardPage()));
            });
    }
    




    // else if(dialogFlagNextTime && boyWalk.x>545 && boyWalk.x<575){
    //     dialogBox = DialogBox(text: 'Hi, I am Some random ass dude , please helpo me', game: this, boyX: boyWalk.x);
    //     add(dialogBox);
    //     dialogFlagFirstTime = false;
    // }
    //dt = 1/60 its delta time
  }

}


