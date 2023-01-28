import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sudokgo/src/game_screen/game_difficulty.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/main_screen/continue_or_new_dialog.dart';
import 'package:sudokgo/src/main_screen/solo_online_switch.dart';
import 'package:sudokgo/src/monetization/ads_preference.dart';
import 'package:sudokgo/src/monetization/banner_ad.dart';
import 'package:sudokgo/src/widgets/menu_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (AdsPreference.current.value == AdsPreference.minimal) const SudokGoBannerAd(),
            ],
          ),
        ),
      ),
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
                          splashRadius: 30.0,
                          icon: Image.asset(
                            'assets/images/menu.png',
                            color: Theme.of(context).colorScheme.onBackground,  
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
                subtitle: 'best time: coming soon!',
                width: MediaQuery.of(context).size.width / 1.25,
                suffixIcon: const Text(
                  '>',
                  style: TextStyle(
                    fontSize: 48.0,
                  ),
                ),
                onPressed: () {
                  GameSession.selectedDifficulty = GameDifficulty.easy;
                  dialogOrGame(context);
                },
              ),
              SudokGoMenuButton(
                title: GameDifficulty.medium.value,
                subtitle: 'best time: coming soon!',
                width: MediaQuery.of(context).size.width / 1.25,
                suffixIcon: const Text(
                  '>',
                  style: TextStyle(
                    fontSize: 48.0,
                  ),
                ),
                onPressed: () {
                  GameSession.selectedDifficulty = GameDifficulty.medium;
                  dialogOrGame(context);
                },
              ),
              SudokGoMenuButton(
                title: GameDifficulty.hard.value,
                subtitle: 'best time: coming soon!',
                width: MediaQuery.of(context).size.width / 1.25,
                suffixIcon: const Text(
                  '>',
                  style: TextStyle(
                    fontSize: 48.0,
                  ),
                ),
                onPressed: () {
                  GameSession.selectedDifficulty = GameDifficulty.hard;
                  dialogOrGame(context);
                },
              ),
              const SoloOnlineSwitch(),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void dialogOrGame(BuildContext context) {
    if (HiveWrapper.getGame(GameSession.selectedDifficulty!) != null) {
      showDialog(
        context: context,
        builder: (context) => const ContinueOrNewDialog(),
      );
    } else {
      GoRouter.of(context).go('/game');
    }
  }
}
