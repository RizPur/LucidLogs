import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopperWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopperWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.dmSerifText(fontSize: 36.0),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
