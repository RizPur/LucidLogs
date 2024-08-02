import 'package:flutter/material.dart';
import 'package:lucidlogs/components/drawer_tile.dart';
import 'package:lucidlogs/screens/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
          child: Icon(Icons.settings)
          ),
          DrawerTile(title: "Dreams", leading: Icon(Icons.note_add), onTap: () => Navigator.pop(context)),
          DrawerTile(title: "Statistics", leading: Icon(Icons.manage_search_outlined), onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          }),
          DrawerTile(title: "Settings", leading: Icon(Icons.settings), onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          }),
          
      ],),
    );
  }
}