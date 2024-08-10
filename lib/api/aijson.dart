import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AIService {

  // final String apiKey = dotenv.env['API_KEY'] ?? '';
  final String apiUrl = 'https://296a-72-252-123-133.ngrok-free.app/chat/completions'; // Load the backend URL from .env

  // AIService(this.apiKey);

 Future<String> analyzeDream(String dreamContent) async {
    final url = Uri.parse(apiUrl);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "ask",
        "messages": [
          {"role": "user", "content": dreamContent}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Extract the relevant information from the response
      return data['result']; // Adjust based on API response structure
    } else {
      throw Exception('Failed to analyze dream');
    }
  }
}