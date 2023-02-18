import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/types/supabase.dart';

class InviteFriendDialog extends StatefulWidget {
  const InviteFriendDialog({super.key});

  @override
  State<InviteFriendDialog> createState() => _InviteFriendDialogState();
}

class _InviteFriendDialogState extends State<InviteFriendDialog> {
  List<Map<String, dynamic>> friends = [];
  bool loading = true;
  
  @override
  void initState() {
    super.initState();
    SudokGoApi.fetchFriendsByStatus(FriendshipStatus.accepted)
      .then((value) {
        setState(() {
          friends = value;
          loading = false;
        });
        print(friends);
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        'invite a friend',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading) CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primaryContainer,
            )
            else for (int i = 0; i < friends.length; i++) InviteListItem(
              displayName: friends[i]['users']['display_name'],
              email: friends[i]['users']['email'],
              onPressed: () {
                final displayName = friends[i]['users']['display_name'];
                SudokGoApi.initiateCompWithOther(friends[i]['users']['id'])
                  .then((_) => GoRouter.of(context).go('/waiting/$displayName'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InviteListItem extends StatelessWidget {
  const InviteListItem({super.key, required this.displayName, required this.email, required this.onPressed,});

  final String displayName;
  final String email;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 0,
        shadowColor: Theme.of(context).colorScheme.tertiary,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
