import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sudokgo/src/game_screen/game_screen.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/hive/game.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/licenses_screen/licenses_screen.dart';
import 'package:sudokgo/src/main_screen/main_screen.dart';
import 'package:sudokgo/src/multiplayer/game_invitation_screen.dart';
import 'package:sudokgo/src/multiplayer/waiting_screen.dart';
import 'package:sudokgo/src/onboarding/onboarding_screen.dart';
import 'package:sudokgo/src/options_screen/friends/friends_screen.dart';
import 'package:sudokgo/src/options_screen/options_screen.dart';
import 'package:sudokgo/src/sudokgo_functions/page_transition.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  await Hive.initFlutter();
  Hive.registerAdapter(GameAdapter());

  await Hive.openBox('user');
  await Hive.openBox('games');
  await Hive.openBox('preferences');

  await Supabase.initialize(
    url: 'https://cgpnihdkmtdsyhullueq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNncG5paGRrbXRkc3lodWxsdWVxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzE2Njg2MzEsImV4cCI6MTk4NzI0NDYzMX0.cWdiGW5zkYMVBmyiwEiKgxE4XhmIL88WCju6-QN1p8k',
  );

  String initialRoute = '/';
  if (HiveWrapper.getDisplayName() == null) initialRoute = '/onboarding';

  runApp(
    ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SudokGo(
        initialRoute: initialRoute,
      ),
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
            routes: [
              GoRoute(
                path: 'friend_requests',
                pageBuilder: (context, state) => buildPageWithDefaultTransition(
                  child: const FriendRequestsScreen(),
                  context: context,
                  state: state,
                ),
              ),
            ]),
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
        GoRoute(
          path: '/waiting/:display_name',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: WaitingScreen(
              displayName: state.params['display_name']!,
            ),
          ),
        ),
        GoRoute(
          path: '/game_invitation/:display_name/:ouid',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: GameInvitationScreen(
              displayName: state.params['display_name']!,
              ouid: state.params['ouid']!,
            ),
          ),
        ),
        GoRoute(
          path: '/licenses',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            child: const LicensesScreen(),
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
          brightness: Brightness.dark,
          background: Colors.blueGrey[700]!,
          onBackground: Colors.white,
          surface: Colors.blueGrey[700]!,
          onSurface: Colors.white,
          primary: Colors.purple[100]!,
          primaryContainer: Colors.purple[200],
          onPrimary: Colors.blueGrey[900]!,
          onPrimaryContainer: Colors.white,
          secondary: Colors.blueGrey[900]!,
          secondaryContainer: Colors.grey,
          onSecondary: Colors.white,
          onSecondaryContainer: Colors.white,
          tertiary: Colors.black,
          onTertiary: Colors.white,
          error: Colors.red[900]!,
          onError: Colors.white,
        ),
        fontFamily: 'IndieFlower',
      ),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
