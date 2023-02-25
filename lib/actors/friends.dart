import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tiled/tiled.dart';

import 'mainChar.dart';


class Friend extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final TiledObject friend;

  Friend(this.friend);

@override
Future<void> onLoad() async {
  await super.onLoad();
  sprite = await gameRef.loadSprite('test.png')
    ..srcSize = Vector2.all(100);
  size = Vector2.all(100);
  position = Vector2(friend.x-10,friend.y-250); //correction for y axis

  add(RectangleHitbox(size: Vector2(friend.width,friend.height-300),anchor: Anchor.center,position: size/3
   ));
  print('entered friends.dart');  
   debugMode = true;
} 

@override
void onCollision(Set<Vector2> intersectionPoints, PositionComponent other){
  print('interssection points');
  print(intersectionPoints);
  super.onCollision(intersectionPoints, other);
    if(other is Krishna){
      print('hi, I have collided');
  }




}



} 