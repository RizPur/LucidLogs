import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:lucidlogs/models/dream.dart';
import 'package:path_provider/path_provider.dart';

class DreamDatabase extends ChangeNotifier {
  static late Isar isar;

  // I N I T I A L I Z E 
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    print('Initializing Isar database at ${dir.path}');
    isar = await Isar.open([DreamSchema], directory: dir.path);
  }

  final List<Dream> currentDreams = [];

  // C R E A T E
  Future<void> addDream(String dreamContent) async {
    // Create new Dream object
    final newDream = Dream()
      ..content = dreamContent
      ..createdAt = DateTime.now();

    // Save to db
    print('Adding dream: $dreamContent');
    await isar.writeTxn(() => isar.dreams.put(newDream));
    // Re-read from db
    await getDreams();
  }

  // R E A D
  Future<void> getDreams() async {
    print('Reading all dreams from the database...');
    List<Dream> allDreams = await isar.dreams.where().findAll();
    currentDreams.clear();
    currentDreams.addAll(allDreams);
    print('Total dreams fetched: ${currentDreams.length}');
    notifyListeners();
  }

  // U P D A T E
  Future<void> updateDream(int id, String newContent) async {
    final dream = await isar.dreams.get(id);
    if (dream != null) {
      dream.content = newContent;
      await isar.writeTxn(() => isar.dreams.put(dream));
      print('Updated dream id $id with new content: $newContent');
      await getDreams();
    }
  }

  // D E L E T E
  Future<void> deleteDream(int id) async {
    await isar.writeTxn(() => isar.dreams.delete(id));
    print('Deleted dream id $id');
    await getDreams();
  }
}
