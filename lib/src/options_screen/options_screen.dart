import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/options_screen/display_name_dialog.dart';
import 'package:sudokgo/src/widgets/coming_soon_dialog.dart';
import 'package:sudokgo/src/widgets/menu_button.dart';
import 'package:sudokgo/src/widgets/sudokgo_app_bar.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          GoRouter.of(context).go('/');
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
                    width: MediaQuery.of(context).size.width / 1.25,
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
                    width: MediaQuery.of(context).size.width / 1.25,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ComingSoonDialog(),
                      );
                    },
                  ),
                  gap,
                  SudokGoMenuButton(
                    title: 'ads preference',
                    subtitle: 'none',
                    suffixIcon: SizedBox(
                      width: 50.0,
                      child: Image.asset('assets/images/spin_icon.png'),
                    ),
                    width: MediaQuery.of(context).size.width / 1.25,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ComingSoonDialog(),
                      );
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
                    width: MediaQuery.of(context).size.width / 1.25,
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
    );
  }

  final SizedBox gap = const SizedBox(height: 30.0,);
}
