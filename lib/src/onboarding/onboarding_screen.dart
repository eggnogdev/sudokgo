import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/hive_wrapper/hive_wrapper.dart';

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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Welcome to SudokGo!',
                style: TextStyle(
                  fontSize: 32.0,
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
                    const Text(
                      'pick a display name',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Stack(
                      children: [
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            suffixIcon: const SizedBox(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade300,
                          ),
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Positioned(
                          right: 6,
                          bottom: 9,
                          child: GestureDetector(
                            onTap: () async {
                              final String name = _controller.value.text;
                              if (name != '') {
                                await HiveWrapper.setDisplayName(_controller.value.text);
                                GoRouter.of(context).go('/');
                              }
                            },
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Center(
                                child: Text(
                                  '>',
                                  style: TextStyle(
                                    height: 1.1,
                                    fontSize: 50.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                'dedicated to Lauren',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
