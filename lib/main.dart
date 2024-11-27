import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash/src/core/di/di.dart';
import 'package:unsplash/src/presentation/provider/home_provider.dart';
import 'package:unsplash/src/presentation/routes/app_routes.dart';
import 'package:unsplash/src/presentation/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<HomeProvider>()..getImages(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash by Aifer',
      scaffoldMessengerKey: scaffoldKey,
      navigatorKey: navKey,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.home:
            return MaterialPageRoute(builder: (settings) => const HomeView());
          default:
        }
        return null;
      },
    );
  }
}
