import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:lucidlogs/models/dream.dart';
import 'package:path_provider/path_provider.dart';

class DreamDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialize the Isar database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    print('Initializing Isar database at ${dir.path}');
    isar = await Isar.open([DreamSchema], directory: dir.path);
  }

  final List<Dream> currentDreams = [];

  // Create a new dream entry
  Future<void> addDream(String dreamContent) async {
    final newDream = Dream()
      ..content = dreamContent
      ..createdAt = DateTime.now();

    print('Adding dream: $dreamContent');
    await isar.writeTxn(() => isar.dreams.put(newDream));
    await getDreams(); // Refresh the list after adding a new dream
  }

  // Read all dreams from the database
  Future<void> getDreams() async {
    print('Reading all dreams from the database...');
    final allDreams = await isar.dreams.where().findAll();
    currentDreams.clear();
    currentDreams.addAll(allDreams);
    print('Total dreams fetched: ${currentDreams.length}');
    notifyListeners();
  }

  // Update an existing dream entry
  Future<void> updateDream(int id, String newContent) async {
    final dream = await isar.dreams.get(id);
    if (dream != null) {
      dream.content = newContent;
      await isar.writeTxn(() => isar.dreams.put(dream));
      print('Updated dream id $id with new content: $newContent');
      await getDreams(); // Refresh the list after updating
    }
  }

  // Delete a dream entry
  Future<void> deleteDream(int id) async {
    await isar.writeTxn(() => isar.dreams.delete(id));
    print('Deleted dream id $id');
    await getDreams(); // Refresh the list after deleting
  }

  // Send the dream content to the backend and receive the analysis
  Future<String> sendDreamToBackend(String content) async {
    const String backendUrl = 'https://296a-72-252-123-133.ngrok-free.app/chat/completions';

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "model": "ask",
          "messages": [
            {"role": "user", "content": content}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final analysis = decodedResponse['choices'][0]['message']['content'];
        return analysis; // Return the analysis from the backend
      } else {
        print('Failed to get dream analysis: ${response.statusCode}');
        return 'Error retrieving analysis';
      }
    } catch (e) {
      print('Error sending dream to backend: $e');
      return 'Error retrieving analysis';
    }
  }

  Future<String> troubleshootRequest() async {

    const String backendUrl = 'https://296a-72-252-123-133.ngrok-free.app/chat/completions';
    final url = Uri.parse(backendUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "ask",
          "messages": [
            {"role": "user", "content": "I dreamt about eating food!"}
          ]
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Response headers: ${response.headers}');

      return response.body;
    } catch (e) {
      print('Error during troubleshooting request: $e');
      return e.toString();
    }
  }
}