import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucidlogs/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _currentFontSize = 16.0; // Default font size

  @override
  void initState() {
    super.initState();
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentFontSize = prefs.getDouble('fontSize') ?? 16.0;
    });
  }

  Future<void> _saveFontSize(double size) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', size);
  }

  Future<void> _pickAccentColor(BuildContext context) async {
    Color currentColor = Theme.of(context).colorScheme.secondary;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Accent Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setAccentColor(color);
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Select'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _adjustFontSize(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adjust Font Size'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Current Font Size: ${_currentFontSize.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: _currentFontSize),
                ),
                Slider(
                  value: _currentFontSize,
                  min: 10.0,
                  max: 30.0,
                  onChanged: (double value) {
                    setState(() {
                      _currentFontSize = value;
                    });
                    _saveFontSize(value);
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSleepRemindersDialog(BuildContext context) {
    // Mockup for setting sleep reminders
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sleep Reminders'),
          content: const Text('Here you can set your sleep reminders.'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showNotificationPreferencesDialog(BuildContext context) {
    // Mockup for setting notification preferences
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Preferences'),
          content:
              const Text('Here you can manage your notification preferences.'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _exportData() {
    // Mockup for exporting data
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data exported successfully!'),
      ),
    );
  }

  void _clearData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Data'),
          content: const Text('Are you sure you want to clear all data?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Clear Data'),
              onPressed: () {
                // Clear all data logic here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All data cleared!'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          _buildSettingsGroup(
            context,
            "Appearance",
            [
              _buildSettingsTile(
                context,
                title: "Dark Mode",
                description: "Toggle between light and dark themes",
                icon: Icons.brightness_6,
                trailing: CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          value ? "Dark Mode Enabled" : "Light Mode Enabled",
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
              _buildSettingsTile(
                context,
                title: "Accent Color",
                description: "Customize the app's accent color",
                icon: Icons.color_lens,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _pickAccentColor(context),
              ),
              _buildSettingsTile(
                context,
                title: "Font Size",
                description: "Adjust the text size for readability",
                icon: Icons.format_size,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _adjustFontSize(context),
              ),
            ],
          ),
          _buildSettingsGroup(
            context,
            "Notifications",
            [
              _buildSettingsTile(
                context,
                title: "Sleep Reminders",
                description: "Set daily sleep reminders",
                icon: Icons.alarm,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showSleepRemindersDialog(context),
              ),
              _buildSettingsTile(
                context,
                title: "Notification Preferences",
                description: "Manage your notifications",
                icon: Icons.notifications,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showNotificationPreferencesDialog(context),
              ),
            ],
          ),
          _buildSettingsGroup(
            context,
            "Data & Privacy",
            [
              _buildSettingsTile(
                context,
                title: "Export Data",
                description: "Export your dream logs and sleep data",
                icon: Icons.download,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _exportData,
              ),
              _buildSettingsTile(
                context,
                title: "Clear Data",
                description: "Delete all logged data",
                icon: Icons.delete,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _clearData,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(
      BuildContext context, String header, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Change color to black
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context,
      {required String title,
      required String description,
      required IconData icon,
      required Widget trailing,
      VoidCallback? onTap}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.inversePrimary),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
