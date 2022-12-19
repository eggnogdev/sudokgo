import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/widgets/text_field.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Welcome to SudokGo!',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                constraints: const BoxConstraints(
                  maxWidth: 400.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'pick a display name',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    SudokGoTextField(
                      controller: _controller,
                      enterOnPressed: () async {
                        final String name = _controller.value.text;
                        if (name != '') {
                          await HiveWrapper.setDisplayName(
                            _controller.value.text,
                          );
                          GoRouter.of(context).go('/');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              Text(
                'dedicated to Lauren',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
