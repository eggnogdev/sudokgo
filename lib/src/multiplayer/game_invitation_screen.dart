import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';

class GameInvitationScreen extends StatefulWidget {
  const GameInvitationScreen({
    super.key,
    required this.displayName,
    required this.ouid,
  });

  final String displayName;
  final String ouid;

  @override
  State<GameInvitationScreen> createState() => _GameInvitationScreenState();
}

class _GameInvitationScreenState extends State<GameInvitationScreen> {
  StreamSubscription? listener;

  @override
  void initState() {
    super.initState();

    listener = SudokGoApi.supabase
        .from('comp_games')
        .stream(primaryKey: ['id'])
        .eq('participant', SudokGoApi.uid)
        .eq('initiator', widget.ouid)
        .listen(
          (List<Map<String, dynamic>> data) {
            if (data.isEmpty) {
              GoRouter.of(context).go('/');
            }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SudokGoApi.endParticipatingComp();
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
                'Invitation from ${widget.displayName}',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      SudokGoApi.acceptParticipatingComp(widget.ouid)
                          .then((_) => GoRouter.of(context).go('/game'));
                    },
                    child: Text(
                      'accept',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  TextButton(
                    onPressed: () {
                      SudokGoApi.endParticipatingComp()
                          .then((_) => GoRouter.of(context).go('/'));
                    },
                    child: Text(
                      'decline',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
