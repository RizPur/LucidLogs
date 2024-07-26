import 'package:flutter/material.dart';
import 'package:lucidlogs/models/dream.dart';
import 'package:lucidlogs/models/dream_db.dart';
import 'package:provider/provider.dart';

class DreamsPage extends StatefulWidget {
  const DreamsPage({super.key});

  @override
  State<DreamsPage> createState() => _DreamsPageState();

}

class _DreamsPageState extends State<DreamsPage> {

  // Create

  final textController = TextEditingController();

  void createDream(){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              //add text to db then pop box
              context.read<DreamDatabase>().addDream(textController.text); 
              Navigator.pop(context);
            },
            child: const Text("Log Dream"),),
        ],
      )
    );
  }

  // Read
  void readNotes() {
    context.watch<DreamDatabase>().getDreams();
  }
  //Update

  //Delete

  @override
  Widget build(BuildContext context) {

    //dream database 
    final dreamDatabase = context.watch<DreamDatabase>();
    List<Dream> currentDreams = dreamDatabase.currentDreams;


    return Scaffold(
      appBar: AppBar(title: const Text("Lucid Logs")),
      floatingActionButton: FloatingActionButton(
        onPressed: createDream,
        child: const Icon(Icons.add)
      ),
      body: ListView.builder(
        itemCount: currentDreams.length,
        itemBuilder: (context, index) {
          final dream = currentDreams[index]; //get note
          
          return ListTile(
            title: Text(dream.content)
          );
        }
      ),
    );
  }
}