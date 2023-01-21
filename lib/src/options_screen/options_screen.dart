import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/monetization/ads_preference.dart';
import 'package:sudokgo/src/online/online_status.dart';
import 'package:sudokgo/src/options_screen/display_name_dialog.dart';
import 'package:sudokgo/src/options_screen/login_dialog.dart';
import 'package:sudokgo/src/widgets/coming_soon_dialog.dart';
import 'package:sudokgo/src/widgets/menu_button.dart';
import 'package:sudokgo/src/widgets/sudokgo_app_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 1.25;
    final Session? session = SudokGoApi.session();

    return WillPopScope(
      onWillPop: () async {
        backOnPressed(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: SudokGoAppBar.create(
          title: Text(
            'options',
            style: TextStyle(
              fontSize: 32.0,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          backOnPressed: () {
            backOnPressed(context);
          },
          context: context,
        ),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 20.0,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SudokGoMenuButton(
                      title: 'display name',
                      subtitle: 'edit your display name',
                      suffixIcon: const Text(
                        '>',
                        style: TextStyle(
                          fontSize: 48.0,
                        ),
                      ),
                      width: width,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const DisplayNameDialog(),
                        );
                      },
                    ),
                    gap,
                    SudokGoMenuButton(
                      title: 'statistics',
                      subtitle: 'view your performance',
                      suffixIcon: SizedBox(
                        width: 50.0,
                        child: Image.asset('assets/images/statistics.png'),
                      ),
                      width: width,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const ComingSoonDialog(),
                        );
                      },
                    ),
                    gap,
                    SudokGoMenuButton(
                      title: 'friend requests',
                      subtitle: 'accept or receive requests',
                      suffixIcon: SizedBox(
                        width: 50.0,
                        child: Image.asset('assets/images/add_friend.png'),
                      ),
                      width: width,
                      onPressed: () {
                        GoRouter.of(context).push('/options/friend_requests');
                      },
                    ),
                    gap,
                    ValueListenableBuilder<AdsPreference>(
                      valueListenable: AdsPreference.current,
                      builder: (context, preference, _) {
                        return SudokGoMenuButton(
                          title: 'ads preference',
                          subtitle: preference.toString(),
                          suffixIcon: SizedBox(
                            width: 50.0,
                            child: Image.asset('assets/images/spin_icon.png'),
                          ),
                          width: width,
                          onPressed: () {
                            int currentValue = HiveWrapper.getAdsPreference().value;
                    
                            if (currentValue == AdsPreference.maxValue) {
                              AdsPreference.current.value = AdsPreference.none;
                              HiveWrapper.setAdsPreference(AdsPreference.none);
                            } else {
                              AdsPreference.current.value = AdsPreference(currentValue + 1);
                              HiveWrapper.setAdsPreference(AdsPreference(currentValue + 1));
                            }
                          },
                        );
                      }
                    ),
                    gap,
                    session == null ? SudokGoMenuButton(
                      width: width,
                      title: 'login',
                      subtitle: 'access online features',
                      suffixIcon: const Icon(
                        Icons.login_rounded,
                        size: 40.0,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const LoginDialog(),
                        );
                      },
                    ) : SudokGoMenuButton(
                      width: width,
                      title: 'logout',
                      subtitle: 'only play solo',
                      suffixIcon: const Icon(
                        Icons.logout_rounded,
                        size: 40.0,
                      ),
                      onPressed: () {
                        SudokGoApi.logout().then((value) => GoRouter.of(context).go('/'));
                        OnlineStatus.online.value = false;
                      },
                    ),
                    gap,
                    SudokGoMenuButton(
                      title: 'licenses',
                      subtitle: 'open source licenses',
                      suffixIcon: SizedBox(
                        width: 50.0,
                        child: Image.asset('assets/images/licenses.png'),
                      ),
                      width: width,
                      onPressed: () {
                        GoRouter.of(context).go('/licenses');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final SizedBox gap = const SizedBox(height: 30.0,);

  void backOnPressed(BuildContext context) {
    GoRouter.of(context).go('/');
  }
}
