import 'package:flutter/material.dart';

class SignUpDetailsPage extends StatelessWidget {
  const SignUpDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF9747FF)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or image
                Image.asset('assets/images/logo.png', height: 100),

                const SizedBox(height: 30),

                // Title
                Text(
                  'Join LucidLogs',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9747FF),
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle
                const Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                // Password input
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Enter password',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 8),

                // Confirm Password input
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 8),

                // Age input
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Age',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                // Confirm button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Confirm sign-up logic here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Color(0xFF9747FF), // Purple color
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Terms and privacy policy
                Text(
                  'By clicking continue, you agree to our',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Open terms and privacy policy
                  },
                  child: const Text(
                    'Terms of Service and Privacy Policy',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9747FF), // Purple color
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
