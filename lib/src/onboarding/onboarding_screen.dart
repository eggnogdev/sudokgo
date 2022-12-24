import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/widgets/text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final tooltipKey = GlobalKey<TooltipState>();

  bool obscurePassword = true;
  bool createAccount = false;
  bool enterEmail = false;

  bool loading = false;
  bool redirecting = false;

  late StreamSubscription<AuthState> authStateSubscription;

  String emailSubText = '';
  bool emailSubTextError = false;

  @override
  void initState() {
    authStateSubscription = SudokGoApi.supabase.auth.onAuthStateChange.listen((data) {
      if (redirecting) return;
      final session = data.session;
      if (session != null) {
        redirecting = true;
        GoRouter.of(context).go('/');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    authStateSubscription.cancel();
    super.dispose();
  }

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
              !enterEmail ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                constraints: const BoxConstraints(
                  maxWidth: 400.0,
                ),
                child: SudokGoTextField(
                  title: 'pick a display name',
                  controller: nameController,
                  suffixButtonOnPressed: () async {
                    final String name = nameController.value.text;
                    if (name != '') {
                      await HiveWrapper.setDisplayName(
                        nameController.value.text,
                      );
                      setState(() {
                        enterEmail = true;
                      });
                      emailFocusNode.requestFocus();
                    }
                  },
                ),
              ) : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                constraints: const BoxConstraints(
                  maxWidth: 400.0,
                ),
                child: SudokGoTextField(
                  focusNode: emailFocusNode,
                  title: 'email address',
                  controller: emailController,
                  subText: emailSubText,
                  subTextIsError: emailSubTextError,
                  showSuffixButton: true,
                  suffixButtonIcon: loading ? const CircularProgressIndicator() : null,
                  suffixButtonOnPressed: loading ? null : () {
                    setState(() {
                      emailSubText = '';
                    });
                    if (emailController.text == '') {
                      GoRouter.of(context).go('/');
                    } else {
                      login(emailController.text);
                    }
                  },
                  titleIcon: Tooltip(
                    preferBelow: false,
                    key: tooltipKey,
                    message: 'enter a blank email to login later',
                    showDuration: const Duration(seconds: 3),
                    triggerMode: TooltipTriggerMode.manual,
                    child: IconButton(
                      constraints: const BoxConstraints(
                        maxWidth: 60.0,
                      ),
                      padding: const EdgeInsets.only(),
                      onPressed: () {
                        tooltipKey.currentState?.ensureTooltipVisible();
                      },
                      icon: Image.asset(
                        'assets/images/info.png',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      splashRadius: 15.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'dedicated to Lauren',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(String email) async {
    setState(() {
      loading = true;
    });

    try {
      await SudokGoApi.login(email);
      setState(() {
        emailSubText = 'login link sent to email!';
      });
    } on AuthException catch (error) {
      setState(() {
        emailSubText = error.message;
        emailSubTextError = true;
      });
    } catch (error) {
      setState(() {
        emailSubText = 'Unexpected error';
        emailSubTextError = true;
      });
    }

    setState(() {
      loading = false;
    });
  }
}
