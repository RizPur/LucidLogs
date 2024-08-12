import 'package:flutter/material.dart';

class DreamTile extends StatelessWidget {
  final String text;
  final String dateTime;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String feeling;

  const DreamTile({
    Key? key,
    required this.text,
    required this.dateTime,
    required this.onEdit,
    required this.onDelete,
    required this.feeling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the gradient and text color based on the feeling
    Gradient tileGradient;
    Color textColor;

    switch (feeling) {
      case 'Good':
        tileGradient = const LinearGradient(
          colors: [
            Color(0xFF874ED2),
            Color(0xFF4B2B74)
          ], // Purple to Black gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        textColor = Colors.white;
        break;
      case 'Neutral':
        tileGradient = const LinearGradient(
          colors: [Colors.white, Colors.white], // Solid white
        );
        textColor = Colors.black;
        break;
      case 'Bad':
        tileGradient = const LinearGradient(
          colors: [
            Color(0xFF23B6C6),
            Color(0xFF185C52)
          ], // Teal to Black gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        textColor = Colors.white;
        break;
      default:
        tileGradient = const LinearGradient(
          colors: [Colors.white, Colors.white], // Fallback to white
        );
        textColor = Colors.black;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: tileGradient, // Apply the gradient
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 4),
            blurRadius: 8.0,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and time
            Text(
              dateTime,
              style: TextStyle(
                color: textColor.withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Dream content
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            // Edit and delete icons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/pen.png',
                    height: 24, // Adjust the size as needed
                    width: 24,
                  ),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/images/delete.png',
                    height: 24, // Adjust the size as needed
                    width: 24,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
