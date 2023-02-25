import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Krishna extends SpriteAnimationComponent with CollisionCallbacks{
  Future<void>onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }
}