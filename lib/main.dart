import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/pages/landing_page.dart';
import 'package:myapp/widgets/drawer.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyPortfolioApp()));
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPortfolioAppState(),
    );
  }
}

class MyPortfolioAppState extends ConsumerWidget {
  const MyPortfolioAppState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home:  LandingPage(),
    );
  }
}


