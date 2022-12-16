import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:sudokgo/src/fonts_and_icons/sudokgo_icons_icons.dart';
import 'package:sudokgo/src/hive_wrapper/hive_wrapper.dart';
import 'package:sudokgo/src/main_screen/difficulty_selection_button.dart';
import 'package:sudokgo/src/main_screen/solo_online_switch.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          onPressed: () {},
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
              DifficultySelectionButton(
                title: 'easy',
                bestTime: 'n/a',
                onPressed: () {},
              ),
              DifficultySelectionButton(
                title: 'medium',
                bestTime: 'n/a',
                onPressed: () {},
              ),
              DifficultySelectionButton(
                title: 'hard',
                bestTime: 'n/a',
                onPressed: () {},
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
