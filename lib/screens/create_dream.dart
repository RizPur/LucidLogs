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
              // style: TextStyle(backgroundColor: Colors.red),
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
                  backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.secondary), // Background color
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Padding inside the button
                  ),
                  textStyle: WidgetStateProperty.all<TextStyle>(
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.inversePrimary)  , // Text style
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                  ), 
                ),
              child: const Text('Log Dream'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_dreamController.text.isNotEmpty) {
                  widget.onDreamAdded(_dreamController.text);
                  Navigator.pop(context);
                }
              },
              
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.lightBlue), // Background color
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Padding inside the button
                  ),
                  textStyle: WidgetStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Text style
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                  ), 
                ),
              child: const Text('Analyze Dream with AI'),
                         
              ),

          ],
        ),
      ),
    );
  }
}
