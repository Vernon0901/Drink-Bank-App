import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts for custom text styling
import 'dart:io'; // Import File class for handling local image files

class DrinkCard extends StatelessWidget {
  final Map<String, dynamic> drink; // Drink data containing name and image

  const DrinkCard({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Rounded corners for the card
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Stretch children to fill the width
        children: [
          // Drink image section
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ), // Rounded corners for the top of the image
              child:
                  drink['image'].startsWith('http')
                      ? Image.network(
                        drink['image'], // Load image from a URL
                        fit: BoxFit.cover, // Cover the entire space
                      )
                      : Image.file(
                        File(drink['image']), // Load image from a local file
                        fit: BoxFit.cover,
                      ),
            ),
          ),
          // Drink name section
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Add padding around the text
              child: Text(
                drink['name'], // Display the drink name
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Use Lato font with bold style
                ),
                textAlign: TextAlign.center, // Center-align the text
              ),
            ),
          ),
        ],
      ),
    );
  }
}
