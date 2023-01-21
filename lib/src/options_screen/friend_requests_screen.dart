import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/widgets/sudokgo_app_bar.dart';

class FriendRequestsScreen extends StatefulWidget {
  const FriendRequestsScreen({super.key});

  @override
  State<FriendRequestsScreen> createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> with SingleTickerProviderStateMixin {
  late TabController controller;
  
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SudokGoAppBar.create(
        context: context,
        title: Text(
          'friend requests',
          style: TextStyle(
            fontSize: 32.0,
            color: Theme.of(context).colorScheme.onBackground
          ),
        ),
        backOnPressed: () {
          GoRouter.of(context).pop();
        },
        bottom: TabBar(
          indicatorColor: Theme.of(context).colorScheme.primary,
          controller: controller,
          labelColor: Theme.of(context).colorScheme.onBackground,
          labelStyle: TextStyle(
            fontSize: 20.0,
            fontFamily: 'IndieFlower'
          ),
          tabs: const [
            Tab(
              text: 'incoming',
            ),
            Tab(
              text: 'outgoing',
            ),
          ],
        )
      ),
      body: SafeArea(
        child: TabBarView(
          controller: controller,
          children: [
            Container(color: Colors.red,),
            Container(color: Colors.orange,)
          ],
        ),
      ),
    );
  }
}
