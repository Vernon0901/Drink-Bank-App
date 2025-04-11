import 'package:flutter/material.dart';
import 'dart:io';

class DrinkDetailPage extends StatelessWidget {
  final Map<String, dynamic> drink;
  const DrinkDetailPage({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          drink['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image:
                  drink['image'].startsWith('http')
                      ? NetworkImage(drink['image']) as ImageProvider
                      : FileImage(File(drink['image'])),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                drink['description'],
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
