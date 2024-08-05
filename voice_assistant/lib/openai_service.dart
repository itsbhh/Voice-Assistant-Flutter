import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:voice_assistant/secrets.dart';

class OpenAIService {
  final List<Map<String, String>> messages = [];

  final String apiKey = OpenAIAPIKey;
  final GenerativeModel model;
  final String unsplashAccessKey = UnsplashAccessKey; // Add your Unsplash API key to secrets.dart

  OpenAIService()
      : model = GenerativeModel(
          model: 'gemini-1.5-flash-latest',
          apiKey: OpenAIAPIKey,
        );

  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final content = [
        Content.text(
          "Does this message want to generate an AI picture, image, art or anything similar? $prompt. Simply answer with a yes or no.",
        ),
      ];

      final response = await model.generateContent(content);
      final generatedText = response.text?.trim() ?? '';

      switch (generatedText.toLowerCase()) {
        case 'yes':
        case 'yes.':
          return await dallEAPI(prompt);
        default:
          return await chatGPTAPI(prompt);
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });

    try {
      final content = [Content.text(prompt)];

      final response = await model.generateContent(content);
      final generatedText = response.text?.trim() ?? '';

      messages.add({
        'role': 'assistant',
        'content': generatedText,
      });
      return generatedText;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });

    try {
      final url = 'https://api.unsplash.com/search/photos?query=${Uri.encodeComponent(prompt)}&client_id=$unsplashAccessKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          final imageUrl = data['results'][0]['urls']['regular'];
          messages.add({
            'role': 'assistant',
            'content': imageUrl,
          });
          return imageUrl;
        } else {
          return 'No image found for the given prompt';
        }
      } else {
        return 'Failed to load image from Unsplash';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
