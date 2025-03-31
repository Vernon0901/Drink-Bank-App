import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(home: GeminiPage()));
}

class GeminiPage extends StatefulWidget {
  const GeminiPage({super.key});

  @override
  State<GeminiPage> createState() => _MyGeminiPageState();
}

class _MyGeminiPageState extends State<GeminiPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages = []; // List of messages

  void _sendMessage() async {
    // Call Gemini API
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: dotenv.env['GeminiAPI']!, // Load API key from .env
      // Replace with your API key
    );

    final userMessage = _textController.text.trim();
    if (userMessage.isEmpty) {
      return; // Do nothing if the text field is empty
    }

    // Add user message to the list
    setState(() {
      _messages.add({"role": "user", "message": userMessage});
    });

    // Clear the text field
    _textController.clear();

    final content = [Content.text(userMessage)];
    final response = await model.generateContent(content);

    // Add Gemini response to the list
    setState(() {
      _messages.add({
        "role": "gemini",
        "message":
            response.text?.trim() ??
            "No response", //.trim() removes leading and trailing spaces or newlines from response.text.
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gemini Chat"), centerTitle: true),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["role"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isUser
                              ? const Color.fromARGB(255, 98, 185, 255)
                              : const Color.fromARGB(255, 234, 234, 234),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message["message"]!,
                      textAlign:
                          TextAlign.justify, // if you want to make it justify
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Input area
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Text field
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    onSubmitted: (value) {
                      _sendMessage(); // Send message on enter
                    },
                  ),
                ),

                // Send button
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
