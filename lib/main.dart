import 'package:flutter/material.dart';
import 'package:lucidlogs/models/dream_db.dart';
import 'package:lucidlogs/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'screens/dreams.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DreamDatabase.initialize();

  runApp(
   MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DreamDatabase()),
    ChangeNotifierProvider(create: (context) => ThemeProvider())
   ],
   child: const MyApp(),
   ), 
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DreamsPage(),
      theme: Provider.of<ThemeProvider>(context).themeData
    );
  }
}
