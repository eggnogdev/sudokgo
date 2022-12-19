import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sudokgo/src/game_screen/game_screen.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/hive/game.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/main_screen/main_screen.dart';
import 'package:sudokgo/src/onboarding/onboarding_screen.dart';
import 'package:sudokgo/src/options_screen/options_screen.dart';
import 'package:sudokgo/src/page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(GameAdapter());
  
  await Hive.openBox('user');
  await Hive.openBox('games');

  String initialRoute = '/';
  if (HiveWrapper.getDisplayName() == null) initialRoute = '/onboarding';

  runApp(
    SudokGo(
      initialRoute: initialRoute,
    ),
  );
}

class SudokGo extends StatelessWidget {
  const SudokGo({
    super.key,
    this.initialRoute,
  });

  final String? initialRoute;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: initialRoute ?? '/',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            child: const MainScreen(),
            context: context,
            state: state,
          ),
        ),
        GoRoute(
          path: '/onboarding',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            child: const OnboardingScreen(),
            context: context,
            state: state,
          ),
        ),
        GoRoute(
          path: '/options',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            child: const OptionsScreen(),
            context: context,
            state: state,
          ),
        ),
        GoRoute(
          path: '/game',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            child: GameScreen(
              gameSession: GameSession(),
            ),
            context: context,
            state: state,
          ),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'SudokGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          background: Colors.blueGrey[50]!,
          onBackground: Colors.black,
          surface: Colors.blueGrey[50]!,
          onSurface: Colors.black,
          primary: Colors.purple[200]!,
          primaryContainer: Colors.deepPurple[200],
          onPrimary: Colors.white,
          onPrimaryContainer: Colors.white,
          secondary: Colors.grey[300]!,
          secondaryContainer: Colors.grey,
          onSecondary: Colors.black,
          onSecondaryContainer: Colors.white,
          error: Colors.red[900]!,
          onError: Colors.white,
        ),
        textTheme: GoogleFonts.indieFlowerTextTheme(),
      ),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
