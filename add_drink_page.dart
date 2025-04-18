import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


class AddDrinkPage extends StatefulWidget {
  const AddDrinkPage({super.key});

  @override
  _AddDrinkPageState createState() => _AddDrinkPageState();
}

class _AddDrinkPageState extends State<AddDrinkPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(
          pickedFile.path,
        ); // Store the selected image as a File
      });
    }
  }

  // Function to generate a description for the drink using the Gemini API
  Future<void> _generateDescription() async {
    if (_nameController.text.isEmpty) return;

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: "Add your own API key", // API key from environment variables
    );

    final prompt = """
    Generate a professional description for a drink called "${_nameController.text}".
    Describe its appearance, flavor profile, and typical ingredients.
    Keep it between 50-100 words.
    Format: Short paragraph, no bullet points.
    """;

      final response = await model.generateContent([Content.text(prompt)]);
      _descriptionController.text = response.text ?? "No description generated";
  }

  // Function to save the drink's details and return them to the previous page
  void _saveDrink() {
    if (_nameController.text.isEmpty || _imageFile == null) {
      // Show a message if name or image is missing
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the name and upload an image.'),
        ),
      );
      return;
    }

    Navigator.pop(context, {
      'name': _nameController.text,
      'image': _imageFile!.path,
      'description': _descriptionController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Drink')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Image upload section
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                color: Colors.grey[300],
                child:
                    _imageFile == null
                        ? const Center(child: Text('Tap to upload image'))
                        : Image.file(_imageFile!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),

            // Drink name input field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Drink Name'),
            ),

            // Drink description input field
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),

            // Button to generate description
            ElevatedButton(
              onPressed: _generateDescription,
              child: const Text('Generate Description'),
            ),
            const Spacer(),

            // Button to save the drink
            ElevatedButton(
              onPressed: _saveDrink,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Save Drink'),
            ),
          ],
        ),
      ),
    );
  }
}
