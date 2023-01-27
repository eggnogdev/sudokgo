import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/options_screen/friends/add_friend_dialog.dart';
import 'package:sudokgo/src/options_screen/friends/friend_list_item.dart';
import 'package:sudokgo/src/types/supabase.dart';
import 'package:sudokgo/src/widgets/sudokgo_app_bar.dart';

import 'bottom_button.dart';

class FriendRequestsScreen extends StatefulWidget {
  const FriendRequestsScreen({super.key});

  @override
  State<FriendRequestsScreen> createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> {
  List<Map<String, dynamic>> relationships = [];
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  FriendshipStatus showingStatus = FriendshipStatus.accepted;

  @override
  void initState() {
    super.initState();

    // without Future.delayed() the function will simply not run, odd
    Future.delayed(const Duration(), () {
      refreshKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: SudokGoAppBar.create(
        context: context,
        title: Text(
          'friends',
          style: TextStyle(
            fontSize: 32.0,
            color: Theme.of(context).colorScheme.onBackground
          ),
        ),
        backOnPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: SafeArea(
        child: RefreshIndicator(
          key: refreshKey,
          color: Theme.of(context).colorScheme.primaryContainer,
          backgroundColor: Theme.of(context).colorScheme.surface,
          onRefresh: onRefresh,
          child: ListView.builder(
            itemCount: relationships.length,
            itemBuilder: (context, index) {
              final current = relationships[index];
              if (current['source_user_id'] == SudokGoApi.supabase.auth.currentUser?.id) {
                return FriendListItem(
                  displayName: current['users']['display_name'],
                  email: current['users']['email'],
                  rightButtonText: 'cancel',
                  rightButtonOnPressed: () {},
                );
              } else if (current['target_user_id'] == SudokGoApi.supabase.auth.currentUser?.id) {
                return FriendListItem(
                  displayName: current['users']['display_name'],
                  email: current['users']['email'],
                  rightButtonText: 'accept',
                  rightButtonIsPrimary: true,
                  rightButtonOnPressed: () {},
                  leftButtonText: 'decline',
                  leftButtonOnPressed: () {},
                );
              } else {
                return const SizedBox();
              }
            }
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddFriendDialog()
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const Text(
          '+',
          style: TextStyle(
            fontSize: 55.0,
            height: 1.1,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            BottomButton(
              onPressed: () {
                onStatusPressed(FriendshipStatus.accepted);
              },
              text: 'accepted',
            ),
            BottomButton(
              onPressed: () {
                onStatusPressed(FriendshipStatus.pending);
              },
              text: 'pending',
            ),
            BottomButton(
              onPressed: () {
                onStatusPressed(FriendshipStatus.blocked);
              },
              text: 'blocked',
            ),
          ],
        ),
      ),
    );
  }

  void onStatusPressed(FriendshipStatus status) {
    if (showingStatus == status) return;
    showingStatus = status;
    refreshKey.currentState?.show();
  }

  Future<void> onRefresh() async {
    final res = await SudokGoApi.fetchFriendsByStatus(showingStatus);
    setState(() {
      relationships = res;
    });
  }
}
