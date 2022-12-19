import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/fonts_and_icons/sudokgo_icons_icons.dart';
import 'package:sudokgo/src/game_screen/game_difficulty.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/main_screen/solo_online_switch.dart';
import 'package:sudokgo/src/widgets/menu_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          iconSize: 50.0,
                          splashRadius: 0.1,
                          icon: Icon(
                            SudokGoIcons.menu,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            GoRouter.of(context).go('/options');
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Welcome, ${HiveWrapper.getDisplayName()}!',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SudokGoMenuButton(
                title: GameDifficulty.easy.value,
                subtitle: 'best time: n/a',
                width: MediaQuery.of(context).size.width / 1.25,
                suffixIcon: const Text(
                  '>',
                  style: TextStyle(
                    fontSize: 48.0,
                  ),
                ),
                onPressed: () {
                  GameSession.selectedDifficulty = GameDifficulty.easy;
                  GoRouter.of(context).go('/game');
                },
              ),
              SudokGoMenuButton(
                title: GameDifficulty.medium.value,
                subtitle: 'best time: n/a',
                width: MediaQuery.of(context).size.width / 1.25,
                suffixIcon: const Text(
                  '>',
                  style: TextStyle(
                    fontSize: 48.0,
                  ),
                ),
                onPressed: () {
                  GameSession.selectedDifficulty = GameDifficulty.medium;
                  GoRouter.of(context).go('/game');
                },
              ),
              SudokGoMenuButton(
                title: GameDifficulty.hard.value,
                subtitle: 'best time: n/a',
                width: MediaQuery.of(context).size.width / 1.25,
                suffixIcon: const Text(
                  '>',
                  style: TextStyle(
                    fontSize: 48.0,
                  ),
                ),
                onPressed: () {
                  GameSession.selectedDifficulty = GameDifficulty.hard;
                  GoRouter.of(context).go('/game');
                },
              ),
              const SoloOnlineSwitch(),
              const SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
