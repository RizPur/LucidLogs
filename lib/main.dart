import 'package:flutter/material.dart';
import 'package:lucidlogs/models/dream_db.dart';
import 'package:provider/provider.dart';
import 'screens/dreams.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DreamDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => DreamDatabase(),
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DreamsPage(),
    );
  }
}
