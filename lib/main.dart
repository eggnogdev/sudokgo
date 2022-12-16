import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sudokgo/src/hive_wrapper/hive_wrapper.dart';
import 'package:sudokgo/src/main_screen/main_screen.dart';
import 'package:sudokgo/src/onboarding/onboarding_screen.dart';
import 'package:sudokgo/src/options_screen/options_screen.dart';
import 'package:sudokgo/src/page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('user');

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
          primary: Colors.purple[400]!,
          primaryContainer: Colors.purple[800],
          onPrimary: Colors.white,
          onPrimaryContainer: Colors.white,
          secondary: Colors.green,
          secondaryContainer: Colors.green[800],
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
