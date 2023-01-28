import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/options_screen/friends/add_friend_dialog.dart';
import 'package:sudokgo/src/options_screen/friends/friend_list_item.dart';
import 'package:sudokgo/src/sudokgo_functions/show_snackbar.dart';
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
  bool refreshing = true;

  @override
  void initState() {
    // call the refresh once the page is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshKey.currentState?.show();
    });
    super.initState();
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
        child: Stack(
          children: [
            Center(
              child: Text(
                'nothing to see here! :)',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            RefreshIndicator(
              key: refreshKey,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              onRefresh: onRefresh,
              child: Container(
                color: relationships.isNotEmpty || refreshing ?
                  Theme.of(context).colorScheme.background :
                  Colors.transparent,
                child: ListView.builder(
                  itemCount: relationships.length,
                  itemBuilder: (context, index) {
                    final current = relationships[index];
                    print(current);
                    if (
                      current['source_user_id'] == SudokGoApi.supabase.auth.currentUser?.id &&
                      FriendshipStatus.pending == current['status']
                    ) {
                      return FriendListItem(
                        displayName: current['users']['display_name'],
                        email: current['users']['email'],
                        rightButtonText: 'cancel',
                        rightButtonOnPressed: () {
                          SudokGoApi.removeRelationship(current['users']['id'])
                            .then((_) => showSnackBar(
                              elevation: 2.0,
                              action: SnackBarAction(
                                label: 'refresh',
                                onPressed: () {
                                  refreshKey.currentState?.show();
                                },
                                textColor: Theme.of(context).colorScheme.primary,
                              ),
                              context: context,
                              text: 'refresh to show updates?',
                            ),);
                        },
                      );
                    } else if (
                      current['target_user_id'] == SudokGoApi.supabase.auth.currentUser?.id &&
                       FriendshipStatus.pending == current['status']
                    ) {
                      return FriendListItem(
                        displayName: current['users']['display_name'],
                        email: current['users']['email'],
                        rightButtonText: 'accept',
                        rightButtonIsPrimary: true,
                        rightButtonOnPressed: () {
                          SudokGoApi.acceptPendingRelationship(current['users']['id'])
                            .then((_) => showSnackBar(
                              elevation: 2.0,
                              action: SnackBarAction(
                                label: 'refresh',
                                onPressed: () {
                                  refreshKey.currentState?.show();
                                },
                                textColor: Theme.of(context).colorScheme.primary,
                              ),
                              context: context,
                              text: 'refresh to show updates?',
                            ),);
                        },
                        leftButtonText: 'decline',
                        leftButtonOnPressed: () {
                          SudokGoApi.removeRelationship(current['users']['id'])
                            .then((_) => showSnackBar(
                              elevation: 2.0,
                              action: SnackBarAction(
                                label: 'refresh',
                                onPressed: () {
                                  refreshKey.currentState?.show();
                                },
                                textColor: Theme.of(context).colorScheme.primary,
                              ),
                              context: context,
                              text: 'refresh to show updates?',
                            ),);
                        },
                      );
                    } else if (FriendshipStatus.accepted == current['status']) {
                      return FriendListItem(
                        displayName: current['users']['display_name'],
                        email: current['users']['email'],
                        rightButtonText: 'remove',
                        rightButtonIsPrimary: false,
                        rightButtonOnPressed: () {
                          SudokGoApi.removeRelationship(current['users']['id'])
                            .then((_) => showSnackBar(
                              elevation: 2.0,
                              action: SnackBarAction(
                                label: 'refresh',
                                onPressed: () {
                                  refreshKey.currentState?.show();
                                },
                                textColor: Theme.of(context).colorScheme.primary,
                              ),
                              context: context,
                              text: 'refresh to show updates?',
                            ),);
                        },
                        leftButtonText: 'block',
                        leftButtonOnPressed: () {
                          SudokGoApi.blockRelationship(current['users']['id'])
                            .then((_) => showSnackBar(
                              elevation: 2.0,
                              action: SnackBarAction(
                                label: 'refresh',
                                onPressed: () {
                                  refreshKey.currentState?.show();
                                },
                                textColor: Theme.of(context).colorScheme.primary,
                              ),
                              context: context,
                              text: 'refresh to show updates?',
                            ),);
                        },
                      );
                    } else if (FriendshipStatus.blocked == current['status']) {
                      return FriendListItem(
                        displayName: current['users']['display_name'],
                        email: current['users']['email'],
                        rightButtonText: 'unblock',
                        rightButtonOnPressed: () {
                          SudokGoApi.removeRelationship(current['users']['id'])
                            .then((_) => showSnackBar(
                              elevation: 2.0,
                              action: SnackBarAction(
                                label: 'refresh',
                                onPressed: () {
                                  refreshKey.currentState?.show();
                                },
                                textColor: Theme.of(context).colorScheme.primary,
                              ),
                              context: context,
                              text: 'refresh to show updates?',
                            ),);
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  }
                ),
              ),
            ),
          ],
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
              disabled: showingStatus == FriendshipStatus.accepted,
              onPressed: () {
                onStatusPressed(FriendshipStatus.accepted);
              },
              text: 'accepted',
            ),
            BottomButton(
              disabled: showingStatus == FriendshipStatus.pending,
              onPressed: () {
                onStatusPressed(FriendshipStatus.pending);
              },
              text: 'pending',
            ),
            BottomButton(
              disabled: showingStatus == FriendshipStatus.blocked,
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
    if (refreshing) return;
    showingStatus = status;
    refreshKey.currentState?.show();
  }

  Future<void> onRefresh() async {
    if (mounted) setState(() {
      refreshing = true;
    });
    final res = await SudokGoApi.fetchFriendsByStatus(showingStatus);
    if (mounted) setState(() {
      relationships = res;
      refreshing = false;
    });
  }
}
