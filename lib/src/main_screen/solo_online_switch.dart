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
      background: Theme.of(context).primaryColor,
      colorOn: Theme.of(context).primaryColor,
      colorOff: Theme.of(context).primaryColor,
      buttonColor: Theme.of(context).primaryColorLight,
      inactiveColor: Theme.of(context).primaryColorDark,
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
