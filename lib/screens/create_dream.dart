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
  bool _isLoading = false;
  String? _aiResponse;

  void _analyzeDream() async {
    if (_dreamController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        final dreamDatabase = context.read<DreamDatabase>();
        final aiResponse = await dreamDatabase.sendDreamToBackend(_dreamController.text);
        setState(() {
          _aiResponse = aiResponse;
        });
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

  void _runTroubleshoot() async {
    final dreamDatabase = context.read<DreamDatabase>();
    final troubleshootResponse = await dreamDatabase.troubleshootRequest();
    setState(() {
      _aiResponse = troubleshootResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Dream'),
      ),
      body: SingleChildScrollView(
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
            ElevatedButton(
              onPressed: () {
                if (_dreamController.text.isNotEmpty) {
                  widget.onDreamAdded(_dreamController.text);
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
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
              onPressed: _isLoading
                  ? null // Disable the button while loading
                  : _analyzeDream,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.lightBlue),
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                ),
                textStyle: WidgetStateProperty.all<TextStyle>(
                  const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('Analyze Dream with AI'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _runTroubleshoot,
              child: const Text('Run Troubleshoot'),
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
    );
  }
}
