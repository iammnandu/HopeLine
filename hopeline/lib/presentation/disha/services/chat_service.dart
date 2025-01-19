import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}

class ChatService {
  final String apiUrl =
      'https://api-inference.huggingface.co/models/google/gemma-2-2b-it';
  final String apiKey = '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';

  Future<String> sendMessage(String message) async {
    try {
      // Create a structured prompt template that guides the model's response
      final contextPrompt = '''System: You are Disha, an empathetic recovery companion focused on supporting addiction recovery. Your responses should be:
- Compassionate and non-judgmental
- Based on evidence-based recovery practices
- Practical and actionable
- Focused on building resilience and healthy coping mechanisms

User Message: $message

Instructions: Provide a response in the following JSON format:
{
  "response": {
    "message": "Your complete response here, naturally incorporating acknowledgment, guidance, and encouragement.",
    "suggested_tool": {
      "type": "exercise|strategy|none",
      "id": "tool_id_if_applicable",
      "reason": "Why this tool might help"
    }
  }
}''';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'x-use-cache': 'false',
        },
        body: jsonEncode({
          'inputs': contextPrompt,
          'parameters': {
            'max_new_tokens': 500,
            'temperature': 0.7,
            'top_p': 0.9,
            'do_sample': true,
            'return_full_text': false,
          },
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
          final generatedText = data[0]['generated_text'];
          
          try {
            // Parse the JSON response
            final Map<String, dynamic> parsedResponse = jsonDecode(generatedText);
            
            // Extract just the message content
            String formattedResponse = parsedResponse['response']['message'];
            
            // Add tool suggestion if present and not 'none'
            final suggestedTool = parsedResponse['response']['suggested_tool'];
            if (suggestedTool != null && 
                suggestedTool['type'] != 'none' && 
                suggestedTool['reason'] != null) {
              formattedResponse += '\n\nSuggested Tool: ${suggestedTool['reason']}';
            }
            
            return formattedResponse;
          } catch (e) {
            // If JSON parsing fails, try to extract content between quotes
            // This is a fallback in case the model returns malformed JSON
            final RegExp messagePattern = RegExp(r'"message":\s*"([^"]+)"');
            final match = messagePattern.firstMatch(generatedText.toString());
            if (match != null && match.group(1) != null) {
              return match.group(1)!;
            }
            // If all parsing fails, return the raw text but clean it of JSON artifacts
            return generatedText
                .toString()
                .replaceAll(RegExp(r'[{}\[\]"\\]'), '')
                .replaceAll('response:', '')
                .replaceAll('message:', '')
                .trim();
          }
        }
        throw Exception('Invalid response format');
      } else if (response.statusCode == 503) {
        throw Exception('Model is loading. Please try again in a few moments.');
      } else {
        throw Exception('Failed to get response from API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error communicating with the chatbot: $e');
    }
  }
}