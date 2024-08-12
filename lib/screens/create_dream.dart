import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucidlogs/models/dream_db.dart';

class CreateDreamPage extends StatefulWidget {
  final Function(String) onDreamAdded;

  const CreateDreamPage({Key? key, required this.onDreamAdded})
      : super(key: key);

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

  // Predefined tags list
  final List<String> predefinedTags = [
    'Nightmare',
    'Flying',
    'Falling',
    'Adventure',
    'Strange',
    'Animals',
    'Water',
    'Being Late',
    'Exams',
    'Death',
    'Birth',
    'Time Travel',
    'Being Lost',
    'Aliens',
    'Ghosts',
    'Invisibility',
    'Super Strength',
    'Magic',
    'Meeting a Celebrity',
    'Revisiting Old Places',
    'Familiar Faces',
    'New Friends',
    'Running',
    'Winning',
    'Losing',
    'Kissing',
    'Flying',
    'Teleportation',
    'Darkness',
    'Love',
    'Anger',
    'Confusion',
  ];

  // Selected tags list
  final List<String> selectedTags = [];

  // Feelings list mapped to emojis
  final Map<String, String> feelings = {
    'Good': '😊',
    'Neutral': '😐',
    'Bad': '😞',
  };

  // Controller for PageView
  final PageController _pageController = PageController(viewportFraction: 0.3);

  void _toggleTagSelection(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  void _logDream() async {
    if (_dreamController.text.isNotEmpty) {
      // Combine predefined and custom tags
      List<String> tags = [
        ...selectedTags,
        ..._tagsController.text
            .split(',')
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty)
      ];

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

    String? aiAnalysis;
    String? message;

    try {
      final dreamDatabase = context.read<DreamDatabase>();
      aiAnalysis = await dreamDatabase.sendDreamToBackend(_dreamController.text);

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

      message = 'Dream analyzed and logged successfully!';
    } catch (e) {
      setState(() {
        _aiResponse = "Failed to analyze dream: $e";
      });
      message = 'Failed to analyze dream. Please try again.';
    } finally {
      setState(() {
        _isLoading = false;
      });
      
      try {
        final dreamDatabase = context.read<DreamDatabase>();
        final aiAnalysis =
            await dreamDatabase.sendDreamToBackend(_dreamController.text);

        // Combine predefined and custom tags
        List<String> tags = [
          ...selectedTags,
          ..._tagsController.text
              .split(',')
              .map((tag) => tag.trim())
              .where((tag) => tag.isNotEmpty)
        ];

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
      // Show a SnackBar with the result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ?? 'N/A'),
          duration: const Duration(seconds: 2),
        ),
      );

      // Wait for the SnackBar to disappear before popping the page
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }
}


  void _scrollLeft() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollRight() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Dream'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Stylish Text Box
            TextField(
              controller: _dreamController,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Describe your dream...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .surface
                    .withOpacity(0.05), // Slight background color
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Predefined Tags with parallax effect and clickable arrow indicators
            Stack(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF874ED2), // Purple color for the arrow
                        size: 20,
                      ),
                      onPressed: _scrollLeft,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 60, // Set height for PageView
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: predefinedTags.length,
                          itemBuilder: (context, index) {
                            final tag = predefinedTags[index];
                            final isSelected = selectedTags.contains(tag);
                            return GestureDetector(
                              onTap: () {
                                _toggleTagSelection(tag);
                              },
                              child: AnimatedBuilder(
                                animation: _pageController,
                                builder: (context, child) {
                                  double value = 1.0;
                                  if (_pageController.position.haveDimensions) {
                                    value = _pageController.page! - index;
                                    value = (1 - (value.abs() * 0.3))
                                        .clamp(0.7, 1.0);
                                  }
                                  return Center(
                                    child: Transform.scale(
                                      scale: Curves.easeOut.transform(value),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Chip(
                                  label: Text(tag),
                                  backgroundColor: isSelected
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.2)
                                      : Colors.grey.shade200,
                                  labelStyle: TextStyle(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF874ED2), // Purple color for the arrow
                        size: 20,
                      ),
                      onPressed: _scrollRight,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Custom Tags Input with same styling
            TextField(
              controller: _tagsController,
              decoration: InputDecoration(
                hintText: 'Enter custom tags (comma-separated)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .surface
                    .withOpacity(0.05), // Slight background color
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Feeling selection with emojis and Lucid checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...feelings.keys.map((feeling) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFeeling = feeling;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: _selectedFeeling == feeling
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        feelings[feeling]!,
                        style: TextStyle(
                          fontSize: 32,
                          color: _selectedFeeling == feeling
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),

                // Lucid checkbox
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5, // Make checkbox slightly larger
                      child: Checkbox(
                        value: _isLucid,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isLucid = newValue ?? false;
                          });
                        },
                        activeColor: const Color(0xFF874ED2), // Purple color
                        checkColor: Colors.white, // Checkmark color
                        side: const BorderSide(
                          color: Color(0xFF874ED2), // Always purple border
                          width: 2.0,
                        ),
                      ),
                    ),
                    const Text(
                      'Lucid',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF874ED2), // Purple color
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Log Dream Button
            ElevatedButton(
              onPressed: _logDream,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade400,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Log Dream Without AI',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Analyze Dream Button
            ElevatedButton(
              onPressed: _isLoading ? null : _analyzeDream,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF874ED2), // Purple color
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Analyze Dream with AI',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
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
