import 'package:flutter/material.dart';

class CreateDreamPage extends StatefulWidget {
  final Function(String) onDreamAdded;

  const CreateDreamPage({Key? key, required this.onDreamAdded}) : super(key: key);

  @override
  _CreateDreamPageState createState() => _CreateDreamPageState();
}

class _CreateDreamPageState extends State<CreateDreamPage> {
  final TextEditingController _dreamController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Dream'),
      ),
      body: Padding(
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
              child: const Text('Analyze Dream with AI'),
            ),
          ],
        ),
      ),
    );
  }
}
