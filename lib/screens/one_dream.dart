import 'package:flutter/material.dart';
import 'package:lucidlogs/models/dream.dart';
import 'package:intl/intl.dart';

class DreamDetailPage extends StatelessWidget {
  final Dream dream;

  const DreamDetailPage({Key? key, required this.dream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date for display
    final formattedDate =
        DateFormat('MMMM dd, yyyy - HH:mm').format(dream.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dream Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title section
            Text(
              'Dream Description',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
              thickness: 2,
            ),
            const SizedBox(height: 16),

            // Dream content
            Text(
              dream.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.5, // Better readability
                  ),
            ),
            const SizedBox(height: 24),

            // Date section
            Text(
              'Logged on: $formattedDate',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontStyle: FontStyle.italic,
                  ),
            ),
            const SizedBox(height: 24),

            // Category section
            if (dream.category != null && dream.category!.isNotEmpty) ...[
              Text(
                'Category: ${dream.category}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
            ],

            // Feeling section
            Text(
              'Feeling: ${dream.feeling}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Lucid Dream section
            Text(
              'Lucid Dream: ${dream.isLucid == true ? 'Yes' : 'No'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Tags section
            if (dream.tags.isNotEmpty) ...[
              Text(
                'Tags:',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children:
                    dream.tags.map((tag) => Chip(label: Text(tag))).toList(),
              ),
              const SizedBox(height: 16),
            ] else ...[
              Text(
                'No tags available',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                    ),
              ),
              const SizedBox(height: 16),
            ],
            // AI Analysis Section
            if (dream.aiAnalysis != null && dream.aiAnalysis!.isNotEmpty) ...[
              const Divider(thickness: 2),
              const SizedBox(height: 16),
              Text(
                'AI Analysis',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                dream.aiAnalysis!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
