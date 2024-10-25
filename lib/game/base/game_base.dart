import 'dart:async';

import 'package:catogotchi/game/components/actors/player.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class GameBase extends FlameGame {
  final double appBarHeight;


  GameBase({required this.appBarHeight});
  late Player player;

  @override
  FutureOr<void> onLoad() async {
    final sprite = await loadSprite("character/Cat/cat_10.png");
    player = Player(character: "Cat", normalAppbar: appBarHeight) ..position = Vector2(50, appBarHeight - 50);
    // add(SpriteComponent(sprite: sprite)
    //   ..size = Vector2.all(50)
    //   ..position = Vector2(50, appBarHeight - 50));

    // player = Player(character: 'Cat')..position = Vector2(10, appBarHeight - 10);
    add(player);

    return super.onLoad();
  }
}
