import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Adding a gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF2C003E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                AnimatedLogo(),
                const SizedBox(height: 24),

                // Slogan with a slight glow
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/signup'); // Navigate to SignUp
                  },
                  child: Text(
                    "Unlock the Dreams You Never Knew You Had",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSerifText(
                      fontSize: 28.0,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 15.0,
                          color: const Color.fromARGB(255, 137, 30, 156)
                              .withOpacity(0.7),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Darker Purple Button with slight gradient and glow effect
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/dreams'); // Navigate to Dreams
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    backgroundColor: const Color.fromARGB(255, 83, 10, 95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    shadowColor: Colors.black.withOpacity(0.8),
                    elevation: 10,
                  ),
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.dmSerifText(
                      fontSize: 18.0,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 12.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Example of an animated logo widget
class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Image.asset(
        'assets/images/logo.png', // Make sure the path is correct
        height: 120,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
