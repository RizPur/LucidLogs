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
    // Initialize controllers with the current dream data
    final TextEditingController contentController = TextEditingController(text: dream.content);
    final TextEditingController tagsController = TextEditingController(text: dream.tags.join(', '));
    String selectedFeeling = dream.feeling ?? 'Neutral';
    bool isLucid = dream.isLucid ?? false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text("Modify Dream"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: contentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Edit dream content...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Tags input
              TextField(
                controller: tagsController,
                decoration: const InputDecoration(
                  hintText: 'Edit tags (comma-separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Feeling selection
              DropdownButtonFormField<String>(
                value: selectedFeeling,
                items: ['Good', 'Neutral', 'Bad'].map((feeling) {
                  return DropdownMenuItem<String>(
                    value: feeling,
                    child: Text(feeling),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedFeeling = newValue!;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Feeling',
                ),
              ),
              const SizedBox(height: 16),

              // Lucid checkbox
              CheckboxListTile(
                title: const Text('Was this a lucid dream?'),
                value: isLucid,
                onChanged: (bool? newValue) {
                  isLucid = newValue ?? false;
                },
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              // Prepare tags
              List<String> tags = tagsController.text.split(',').map((tag) => tag.trim()).toList();

              // Update the dream with all new values
              await context.read<DreamDatabase>().updateDream(
                    dream.id,
                    content: contentController.text,
                    tags: tags,
                    feeling: selectedFeeling,
                    isLucid: isLucid,
                  );

              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
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
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddDreamPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: currentDreams.isEmpty
                  ? Center(
                      child: Text(
                        "Welcome to LucidLogs! Start by adding a dream.",
                        style: GoogleFonts.dmSerifText(
                          fontSize: 18.0,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    )
                  : ListView.builder(
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
                            feeling: dream.feeling ??
                                'Neutral', // Provide a default value for the feeling
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
