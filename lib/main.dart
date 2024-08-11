import 'package:flutter/material.dart';
import 'package:lucidlogs/models/dream_db.dart';
import 'package:lucidlogs/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'screens/homepage.dart'; // Import the HomePage
import 'screens/dreams.dart'; // Import the DreamsPage
import 'screens/signup_page.dart'; // Import the SignUpPage
import 'screens/sleep_tracker_page.dart'; // Import the SleepTrackerPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DreamDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DreamDatabase()),
        ChangeNotifierProvider(create: (context) => ThemeProvider())
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
      debugShowCheckedModeBanner: false,
      home: const HomePage(), // Set HomePage as the default start page
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/home': (context) => const HomePage(),
        '/dreams': (context) => const DreamsPage(),
        '/signup': (context) => const SignUpPage(),
        '/sleep_tracker': (context) =>
            const SleepTrackerPage(), // Add Sleep Tracker route
      },
    );
  }
}
