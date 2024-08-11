import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucidlogs/components/drawer.dart';
import 'package:lucidlogs/components/dream_tile.dart';
import 'package:lucidlogs/models/dream.dart';
import 'package:lucidlogs/models/dream_db.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:lucidlogs/screens/create_dream.dart';
import 'package:lucidlogs/screens/one_dream.dart'; // Import the detail page

class DreamsPage extends StatefulWidget {
  const DreamsPage({super.key});

  @override
  State<DreamsPage> createState() => _DreamsPageState();
}

class _DreamsPageState extends State<DreamsPage> {
  final textController = TextEditingController();

  String formatDate(DateTime dt) {
    final DateFormat dateTime = DateFormat('dd-MM-yyyy HH:mm');
    return dateTime.format(dt);
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

  void updateDream(Dream dream) {
    textController.text = dream.content; //fill textfield with dream content
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("Modify Dream"),
              content: TextField(controller: textController),
              actions: [
                MaterialButton(
                  onPressed: () {
                    //update
                    context
                        .read<DreamDatabase>()
                        .updateDream(dream.id, textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                )
              ],
            ));
  }

  void deleteDream(int id) {
    context.read<DreamDatabase>().deleteDream(id);
  }

  void navigateToAddDreamPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateDreamPage(
          onDreamAdded: (dreamContent) async {
            await context.read<DreamDatabase>().addDream(dreamContent);
          },
        ),
      ),
    );
  }

  void navigateToDreamDetail(Dream dream) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DreamDetailPage(dream: dream),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dream database
    final dreamDatabase = context.watch<DreamDatabase>();
    List<Dream> currentDreams = dreamDatabase.currentDreams;

    return Scaffold(
      appBar: AppBar(
        title: Text("Dreams", style: GoogleFonts.dmSerifText(fontSize: 36.0)),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddDreamPage,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: currentDreams.length,
              itemBuilder: (context, index) {
                final dream = currentDreams[index]; // Get 1 dream
                return GestureDetector(
                  onTap: () => navigateToDreamDetail(dream),
                  child: DreamTile(
                    text: dream.content,
                    dateTime: formatDate(dream.createdAt),
                    onEdit: () => updateDream(dream),
                    onDelete: () => deleteDream(dream.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
