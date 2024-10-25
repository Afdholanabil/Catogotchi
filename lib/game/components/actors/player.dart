import 'dart:async';

import 'package:catogotchi/game/base/game_base.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';

class Player extends SpriteAnimationGroupComponent<String>
    with HasGameRef<GameBase>, CollisionCallbacks {
  Player({
    required this.character,
    required this.normalAppbar,
  }) : super(size: Vector2.all(50));

  late final SpriteAnimation idleHappyAnimation;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation idleHungryAnimation;
  late final SpriteAnimation idleEatingAnimation;
  late final SpriteAnimation runningAnimation;

  final double stepTime = 0.1;
  String character;

  bool isAnimating = false;
  double targetY = 0;

  final double normalAppbar;
  double? lastKnownPositionY;

  bool isOnTask = false;

  @override
  FutureOr<void> onLoad() async {
    idleAnimation = await _spriteAnimation('character/Cat/cat_10.png', 1);
    runningAnimation = await _spriteAnimation('character/cat_run.png', 3);
    idleHappyAnimation =
        await _spriteAnimation('character/Cat/cat1_idle_happy_200.png', 4);
    idleHungryAnimation =
        await _spriteAnimation('character/Cat/cat1_idle_hungry_200.png', 6);
    idleEatingAnimation =
        await _spriteAnimation('character/Cat/cat1_idle_eating_200.png', 7);

    animations = {
      'idle': idleAnimation,
      'running': runningAnimation,
      'idle_happy': idleHappyAnimation,
      'idle_hungry': idleHungryAnimation,
      'idle_eating': idleEatingAnimation,
    };

    current = 'idle';
    return super.onLoad();
  }

  Future<SpriteAnimation> _spriteAnimation(String path, int amount) async {
    final image = await Flame.images.load(path);
    return SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(10),
      ),
    );
  }

  void moveOutOfAppBar(double targetY) {
    this.targetY = targetY - 250;
    isAnimating = true;

    lastKnownPositionY = targetY;
    isOnTask = true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isAnimating) {
      final deltaY = (targetY - position.y) * 0.1;
      position.y += deltaY;

      if ((targetY - position.y).abs() < 1) {
        position.y = targetY;
        isAnimating = false;
      }
    } else if (isOnTask) {
      position.y =
          lastKnownPositionY != null ? lastKnownPositionY! - 50 : position.y;
    }
  }
}
