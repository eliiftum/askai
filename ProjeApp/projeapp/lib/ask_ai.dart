import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AskAI extends StatefulWidget {
  const AskAI({super.key});

  @override
  State<AskAI> createState() => _AskAIState();
}

class _AskAIState extends State<AskAI> {
  final TextEditingController _questionController = TextEditingController();
  final model = GenerativeModel(
    model: 'gemini-1.5-pro',
    apiKey: 'AIzaSyCm9wInMJ9aHm6oyIJB7dLcOOVgjWYMfl0', 
  );
  String? _response;
  bool _loading = false;

  void _askQuestion() async {
    if (_questionController.text.isEmpty) return;

    setState(() {
      _loading = true;
    });

    try {
      final content = [Content.text(_questionController.text)];
      final response = await model.generateContent(content);
      
      setState(() {
        _response = response.text;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _response = "Bir hata oluştu: $e";
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                hintText: 'Sorunuzu yazın...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _askQuestion,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Text(_response ?? 'Henüz bir soru sormadınız.'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
} 