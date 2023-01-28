import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/online/online_status.dart';
import 'package:sudokgo/src/sudokgo_functions/show_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SoloOnlineSwitch extends StatelessWidget {
  const SoloOnlineSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final Session? session = SudokGoApi.session();

    return ValueListenableBuilder<bool>(
        valueListenable: OnlineStatus.online,
        builder: (context, value, _) {
          return SlidingSwitch(
            value: value,
            textOff: 'solo',
            textOn: 'online',
            animationDuration: const Duration(milliseconds: 200),
            background: Theme.of(context).colorScheme.surface,
            colorOn: Theme.of(context).colorScheme.onPrimary,
            colorOff: Theme.of(context).colorScheme.onPrimary,
            buttonColor: Theme.of(context).colorScheme.primary,
            onChanged: (value) {
              OnlineStatus.online.value = value;
            },
            disabled: session == null,
            disabledOnTap: () {
              showSnackBar(
                context: context,
                text: 'you must login to play online',
              );
            },
            disabledOnDoubleTap: () {
              showSnackBar(
                context: context,
                text: 'you must login to play online',
              );
            },
            disabledOnSwipe: () {
              showSnackBar(
                context: context,
                text: 'you must login to play online',
              );
            },
          );
        });
  }
}
