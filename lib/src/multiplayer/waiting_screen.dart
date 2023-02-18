import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key, required this.displayName,});

  final String displayName;

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  late StreamSubscription listener;
  
  @override
  void initState() {
    super.initState();

    listener = SudokGoApi.supabase
      .from('comp_games')
      .stream(primaryKey: ['id'])
      .eq('initiator', SudokGoApi.uid)
      .listen((List<Map<String, dynamic>> data) {
        if (data.isEmpty) {
          GoRouter.of(context).go('/');
        } else if (data[0]['accepted']) {
          GoRouter.of(context).go('/game');
        }
      });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SudokGoApi.endInitiatedComp();
        GoRouter.of(context).go('/');
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Waiting for ${widget.displayName}',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  SudokGoApi.endInitiatedComp()
                    .then((_) => GoRouter.of(context).go('/'));
                },
                child: Text(
                  'cancel',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
