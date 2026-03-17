import 'package:flutter/material.dart';
import 'navigation/router.dart';
import 'navigation/routes.dart';
import 'service_locator.dart';
import 'theme/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Menu Flutter',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.onboard,
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
