import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:sudokgo/src/online/online_status.dart';
import 'package:sudokgo/src/widgets/coming_soon_dialog.dart';

class SoloOnlineSwitch extends StatelessWidget {
  const SoloOnlineSwitch({super.key});

  @override
  Widget build(BuildContext context) {
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
          disabled: true,
          disabledOnTap: () {
            showDialog(
              context: context,
              builder: (context) => const ComingSoonDialog(),
            );
          },
          disabledOnDoubleTap: () {
            showDialog(
              context: context,
              builder: (context) => const ComingSoonDialog(),
            );
          },
          disabledOnSwipe: () {
            showDialog(
              context: context,
              builder: (context) => const ComingSoonDialog(),
            );
          },
        );
      }
    );
  }
}
