import 'dart:convert';
import 'dart:io';

import 'package:ai_menu_flutter/features/bottom_navigation/main_screen.dart';
import 'package:ai_menu_flutter/features/onboard_screen/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'navigation/router.dart';
import 'services/ads/init_sdk.dart';
import 'services/app_service.dart';
import 'theme/theme_data.dart';
import 'utils/console.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Platform.isLinux && !Platform.isWindows) {
    try {
      await InitManager.initTopon();
      InitManager.startPreLoadAd();
    } catch (e) {
      Console.error('❌ TopOn init/preload failed: $e');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  DateTime? _backgroundTime;
  bool _isInBackground = false;
  Key _appKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final now = DateTime.now();

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.inactive:
        if (!_isInBackground) {
          _backgroundTime = now;
          _isInBackground = true;
          // Debug log
          Console.log('📱 Time stored: $_backgroundTime');
        }
        break;

      case AppLifecycleState.resumed:
        if (_isInBackground && _backgroundTime != null) {
          final timeInBackground = now.difference(_backgroundTime!);

          Console.log('⏱️  Time in background: ${timeInBackground.inSeconds})');

          if (timeInBackground >= const Duration(minutes: 60)) {
            Console.log('🔴 RESET TRIGGERED! ${timeInBackground.inSeconds}');
            // Force complete app rebuild
            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AppRoot()),
              (route) => false,
            );
            setState(() {
              _appKey = UniqueKey();
            });
            Console.log('✅ App rebuild complete');
          } else {
            Console.log('🟢 No reset (${timeInBackground.inSeconds})');
          }

          _backgroundTime = null;
          _isInBackground = false;
        }
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppContent(key: _appKey);
  }
}

class MyAppContent extends StatelessWidget {
  const MyAppContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppService())],
      child: Consumer<AppService>(
        builder: (context, appService, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'AI Menu Flutter',
            theme: AppTheme.lightTheme,
            onGenerateRoute: AppRouter.generateRoute,
            home: const AppRoot(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppService>(
      builder: (context, appService, _) {
        // if (!appService.initialize) {
        //   return const SplashScreen();
        // }

        // Show onboarding for first time users, otherwise go to main
        if (!appService.onboarded) {
          return const OnboardScreen();
        }
        return const MainScreen();

        // if (!appService.isLogin) return const LoginScreen();
      },
    );
  }
}
