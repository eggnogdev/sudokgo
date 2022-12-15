import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/main_screen.dart';

void main() {
  runApp(const SudokGo());
}

class SudokGo extends StatelessWidget {
  const SudokGo({super.key});

  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SudokGo',
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
