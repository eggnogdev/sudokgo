import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/online/online_status.dart';
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
            showSnackBar(context);
          },
          disabledOnDoubleTap: () {
            showSnackBar(context);
          },
          disabledOnSwipe: () {
            showSnackBar(context);
          },
        );
      }
    );
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10.0,
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'you must login to play online',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontFamily: 'IndieFlower',
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      )
    );
  }
}
