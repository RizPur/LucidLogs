import 'package:flutter/material.dart';
import 'package:lucidlogs/home.dart';
import 'package:lucidlogs/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [HomePage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lucid Logs'), // Adding a text to the AppBar
      ),
      body: pages[currentPage],
      backgroundColor: const Color.fromARGB(255, 247, 187, 207),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("button pushed");
        },
        child: const Icon(Icons.home),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.plumbing_sharp), label: "Profile"),
      ],
      onDestinationSelected: (int index){
        setState(() {
          currentPage = index;  
        });
      },
      selectedIndex: currentPage,),
    );
  }
}
