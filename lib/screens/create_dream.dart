import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucidlogs/models/dream_db.dart';

class CreateDreamPage extends StatefulWidget {
  final Function(String) onDreamAdded;

  const CreateDreamPage({Key? key, required this.onDreamAdded}) : super(key: key);

  @override
  _CreateDreamPageState createState() => _CreateDreamPageState();
}

class _CreateDreamPageState extends State<CreateDreamPage> {
  final TextEditingController _dreamController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  bool _isLoading = false;
  bool _isLucid = false;
  String? _aiResponse;
  String _selectedFeeling = 'Neutral'; // Default feeling

  // Feelings list
  final List<String> feelings = ['Good', 'Neutral', 'Bad'];

  void _logDream() async {
    if (_dreamController.text.isNotEmpty) {
      // Prepare tags
      List<String> tags = _tagsController.text.split(',').map((tag) => tag.trim()).toList();

      // Simply log the dream without AI analysis
      await context.read<DreamDatabase>().addDream(
        _dreamController.text,
        tags: tags,
        feeling: _selectedFeeling,
        isLucid: _isLucid,
      );

      Navigator.pop(context); // Close the page after logging
    }
  }

  void _analyzeDream() async {
    if (_dreamController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        final dreamDatabase = context.read<DreamDatabase>();
        final aiAnalysis = await dreamDatabase.sendDreamToBackend(_dreamController.text);

        // Prepare tags
        List<String> tags = _tagsController.text.split(',').map((tag) => tag.trim()).toList();

        // Log the dream with AI analysis
        await dreamDatabase.addDream(
          _dreamController.text,
          aiAnalysis: aiAnalysis,
          tags: tags,
          feeling: _selectedFeeling,
          isLucid: _isLucid,
        );

        setState(() {
          _aiResponse = aiAnalysis;
        });

        Navigator.pop(context); // Close the page after logging
      } catch (e) {
        setState(() {
          _aiResponse = "Failed to analyze dream: $e";
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Dream'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _dreamController,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Describe your dream...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
        
              // Tags input
              TextField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  hintText: 'Enter tags (comma-separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
        
              // Feeling selection
              DropdownButtonFormField<String>(
                value: _selectedFeeling,
                items: feelings.map((feeling) {
                  return DropdownMenuItem<String>(
                    value: feeling,
                    child: Text(feeling),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedFeeling = newValue!;
                  });
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
                value: _isLucid,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isLucid = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),
        
              ElevatedButton(
                onPressed: _logDream,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  ),
                  textStyle: WidgetStateProperty.all<TextStyle>(
                    TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: const Text('Log Dream'),
              ),
              const SizedBox(height: 16), // Adding some space between buttons
              ElevatedButton(
                onPressed: _isLoading ? null : _analyzeDream,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.lightBlue),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  ),
                  textStyle: WidgetStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Analyze Dream with AI'),
              ),
              const SizedBox(height: 16),
              if (_aiResponse != null)
                Text(
                  'AI Analysis: $_aiResponse',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
