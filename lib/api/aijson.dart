import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AIService {
  final String apiUrl = dotenv.env['API_URL'] ?? '';// Replace with the correct endpoint
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  

  // AIService(this.apiKey);

  Future<String> analyzeDream(String dreamContent) async {
    final url = Uri.parse(apiUrl + "analyze"); // Adjust endpoint as needed
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'text': dreamContent,
        // Add other parameters required by AIJSON here
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