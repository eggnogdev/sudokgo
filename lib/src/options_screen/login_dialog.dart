import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/widgets/text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {

  final controller = TextEditingController();
  String subText = '';
  bool subTextIsError = false;
  bool redirecting = false;
  bool loading = false;
  late StreamSubscription<AuthState> authStateSubscription;

  @override
  void initState() {
    authStateSubscription = SudokGoApi.supabase.auth.onAuthStateChange.listen((data) async {
      if (redirecting) return;
      final session = data.session;
      if (session != null) {
        redirecting = true;
        SudokGoApi.upsertUserRow().then((_) => GoRouter.of(context).go('/'));
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
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: SudokGoTextField(
        controller: controller,
        title: 'email address',
        suffixButtonIcon: loading ? const CircularProgressIndicator() : null,
        suffixButtonOnPressed: loading ? null : () {
          setState(() {
            subText = '';
          });
          if (controller.text != '') {
            login(controller.text);
          }
        },
        subText: subText,
        subTextIsError: subTextIsError,
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
        subText = 'login link sent to email!';
      });
    } on AuthException catch (error) {
      setState(() {
        subText = error.message;
        subTextIsError = true;
      });
    } catch (error) {
      setState(() {
        subText = error.toString();
        subTextIsError = true;
      });
    }
    setState(() {
      loading = false;
    });
  }
}
