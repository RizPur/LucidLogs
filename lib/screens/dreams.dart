import 'package:flutter/material.dart';
import 'package:lucidlogs/models/dream.dart';
import 'package:lucidlogs/models/dream_db.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DreamsPage extends StatefulWidget {
  const DreamsPage({super.key});

  @override
  State<DreamsPage> createState() => _DreamsPageState();
}

class _DreamsPageState extends State<DreamsPage> {
  final textController = TextEditingController();

  String formatDate(DateTime dt){
    final DateFormat dateTime = DateFormat('dd-MM-yyyy HH:mm');
    return dateTime.format(dt);
  }

  void createDream() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              print('Logging dream: ${textController.text}');
              // Add text to db, clear textbox then pop box
              context.read<DreamDatabase>().addDream(textController.text); 
              textController.clear();
              Navigator.pop(context);
              
            },
            child: const Text("Log Dream"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('Initializing DreamsPage...');
    readDreams();
  }

  // Read
  void readDreams() {
    print('Getting dreams from database...');
    context.read<DreamDatabase>().getDreams();
  }

  void updateDream(Dream dream){
    textController.text = dream.content;
  }

  @override
  Widget build(BuildContext context) {
    // Dream database 
    final dreamDatabase = context.watch<DreamDatabase>();
    List<Dream> currentDreams = dreamDatabase.currentDreams;
    // print('Current dreams: ${currentDreams.length}');

    return Scaffold(
      appBar: AppBar(title: const Text("Lucid Logs")),
      floatingActionButton: FloatingActionButton(
        onPressed: createDream,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentDreams.length,
        itemBuilder: (context, index) {
          final dream = currentDreams[index]; // Get dream
          // print('Displaying dream: ${dream.content}');
          return ListTile(
            title: Text(dream.content),
            subtitle: Text(formatDate(dream.createdAt)),
          );
        },
      ),
    );
  }
}
