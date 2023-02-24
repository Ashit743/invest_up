import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tiled/tiled.dart';


class Friend extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final TiledObject friend;

  Friend(this.friend);

@override
Future<void> onLoad() async {
  await super.onLoad();
  sprite = await gameRef.loadSprite('test.png')
    ..srcSize = Vector2.all(200);
  size = Vector2.all(100);
  position = Vector2(friend.x,friend.y-300); //correction for y axis

  add(RectangleHitbox(size: Vector2(friend.width,friend.height-300),anchor: Anchor.center,position: size/2
   ));
} 



} 