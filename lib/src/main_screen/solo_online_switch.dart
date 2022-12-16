import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';

class SoloOnlineSwitch extends StatefulWidget {
  const SoloOnlineSwitch({super.key});

  @override
  State<SoloOnlineSwitch> createState() => _SoloOnlineSwitchState();
}

class _SoloOnlineSwitchState extends State<SoloOnlineSwitch> {
  bool online = false;

  @override
  Widget build(BuildContext context) {
    return SlidingSwitch(
      value: online,
      textOff: 'solo',
      textOn: 'online',
      background: Theme.of(context).colorScheme.surface,
      colorOn: Theme.of(context).colorScheme.onPrimary,
      colorOff: Theme.of(context).colorScheme.onPrimary,
      buttonColor: Theme.of(context).colorScheme.primary,
      onChanged: (value) {
        setState(() {
          online = value;
        });
      },
      onSwipe: () {},
      onTap: () {},
      onDoubleTap: () {},
    );
  }
}
