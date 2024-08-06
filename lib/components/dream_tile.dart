import 'package:flutter/material.dart';

class DreamTile extends StatelessWidget {
  final String text;
  final String dateTime;
  final void Function()? onEdit;
  final void Function()? onDelete;

  const DreamTile({super.key, required this.text, required this.dateTime, this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8)
      ),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      padding: const EdgeInsets.all(8.0), // Add padding inside the container
      child: ListTile(
        title: Text(text),
        subtitle: Text(dateTime),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
            IconButton(onPressed: onDelete, icon: const Icon(Icons.delete))
          ],
        ),
      )
    );
  }
}