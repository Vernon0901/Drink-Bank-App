import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class DrinkCard extends StatelessWidget {
  final Map<String, dynamic> drink;
  const DrinkCard({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child:
                  drink['image'].startsWith('http')
                      ? Image.network(drink['image'], fit: BoxFit.cover)
                      : Image.file(File(drink['image']), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              drink['name'],
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
