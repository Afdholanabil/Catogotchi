import 'package:catogotchi/game/base/game_base.dart';
import 'package:catogotchi/presentation/controllers/game_controllers.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {

  final GameController gameController = Get.find<GameController>();
  final GlobalKey taskKey = GlobalKey();
  final double enlargeAppBar = 250;

  @override
  Widget build(BuildContext context) {
    GameBase game = GameBase(appBarHeight: gameController.appBarHeight.value);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(gameController.appBarHeight.value),
        child: Obx(() {
          return AppBar(
            flexibleSpace: GestureDetector(
              onTap: () {
                gameController.toggleAppBarHeight(enlargeAppBar);
        
                if (!game.player.isAnimating) {
                  game.player.position.y =
                      gameController.appBarHeight.value - 50;
                }
              },
              child: Container(
                height: gameController.appBarHeight.value,
                child: GameWidget(game: game),
              ),
            ),
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 800,
              color: Colors.lightBlueAccent,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('This is the body of the app!'),
                    ElevatedButton(
                      onPressed: () {
                  
                        final RenderBox? renderBox =
                            taskKey.currentContext?.findRenderObject()
                                as RenderBox?;
                        if (renderBox != null) {
                          final offset = renderBox.localToGlobal(Offset.zero);
                          gameController.completeTask(offset.dy, game.player.moveOutOfAppBar);
                        }
                      },
                      child: const Text('Complete Task'),
                    ),
                    const SizedBox(height: 20),
               
                    Container(
                      key: taskKey,
                      width: 300,
                      height: 100,
                      color: Colors.orange,
                      child: const Center(
                        child: Text(
                          'Task: Complete the quiz!',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
