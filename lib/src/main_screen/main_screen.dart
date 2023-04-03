import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/game_screen/game_difficulty.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/main_screen/continue_or_new_dialog.dart';
import 'package:sudokgo/src/main_screen/invite_friend_dialog.dart';
import 'package:sudokgo/src/main_screen/solo_online_switch.dart';
import 'package:sudokgo/src/monetization/ads_preference.dart';
import 'package:sudokgo/src/monetization/banner_ad.dart';
import 'package:sudokgo/src/online/online_status.dart';
import 'package:sudokgo/src/widgets/menu_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late StreamSubscription databaseListener;
  late void Function() onlineStatusListener = () {
    if (OnlineStatus.online.value) {
      databaseListener.resume();
    } else {
      databaseListener.pause();
    }
  };

  @override
  void initState() {
    super.initState();
    databaseListener = SudokGoApi.supabase.from('comp_games').stream(
        primaryKey: ['id']).listen((List<Map<String, dynamic>> data) async {
      if (data.isNotEmpty) {
        if (data[0]['initiator'] == SudokGoApi.uid) return;
        final initiator = await SudokGoApi.supabase
            .from('users')
            .select<List<Map<String, dynamic>>>()
            .eq('id', data[0]['initiator']);
        final displayName = initiator[0]['display_name'];
        final id = initiator[0]['id'];

        GoRouter.of(context).go('/game_invitation/$displayName/$id');
      }
    });
    if (OnlineStatus.online.value) {
      databaseListener.resume();
    } else {
      databaseListener.pause();
    }
    OnlineStatus.online.addListener(onlineStatusListener);
  }

  @override
  void dispose() {
    databaseListener.cancel();
    OnlineStatus.online.removeListener(onlineStatusListener);
    super.dispose();
  }

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
              if (AdsPreference.current.value == AdsPreference.minimal)
                const SudokGoBannerAd(),
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
                  if (OnlineStatus.online.value) {
                    showDialog(
                      context: context,
                      builder: (context) => const InviteFriendDialog(),
                    );
                  } else {
                    dialogOrGame(context);
                  }
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
                  if (OnlineStatus.online.value) {
                    showDialog(
                      context: context,
                      builder: (context) => const InviteFriendDialog(),
                    );
                  } else {
                    dialogOrGame(context);
                  }
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
                  if (OnlineStatus.online.value) {
                    showDialog(
                      context: context,
                      builder: (context) => const InviteFriendDialog(),
                    );
                  } else {
                    dialogOrGame(context);
                  }
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
