import 'package:flutter/material.dart';
import 'package:lucidlogs/components/drawer_tile.dart';
import 'package:lucidlogs/screens/settings.dart';
import 'package:lucidlogs/screens/stats_page.dart';
import 'package:lucidlogs/screens/signup_page.dart';
import 'package:lucidlogs/screens/homepage.dart'; // Import HomePage
import 'package:lucidlogs/screens/sleep_tracker_page.dart'; // Import SleepTrackerPage

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Drawer(
      backgroundColor: Colors.grey.shade800,
      child: Column(
        children: [
          const DrawerHeader(child: Icon(Icons.settings, color: Colors.white)),
          DrawerTile(
            title: "Home",
            leading: Icon(Icons.home, color: textColor),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const HomePage())); // Navigate to HomePage
            },
          ),
          DrawerTile(
            title: "Sign Up",
            leading: Icon(Icons.person_add, color: textColor),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()));
            },
          ),
          DrawerTile(
            title: "LucidLogs",
            leading: Icon(Icons.note_add, color: textColor),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: "Statistics",
            leading: Icon(Icons.manage_search_outlined, color: textColor),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const StatsPage())); // Navigate to StatsPage
            },
          ),
          DrawerTile(
            title: "Settings",
            leading: Icon(Icons.settings, color: textColor),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
          DrawerTile(
            title: "Sleep Tracker",
            leading:
                Icon(Icons.bed, color: textColor), // Icon for sleep tracker
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SleepTrackerPage())); // Navigate to SleepTrackerPage
            },
          ),
        ],
      ),
    );
  }
}
