import 'package:flutter/material.dart'; // Import Flutter material package for UI components
import 'package:drink_bank/Page/add_drink_page.dart'; // Import AddDrinkPage for adding drinks
import 'package:drink_bank/Page/home_page.dart'; // Import HomePage as the main screen
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts for custom text styling
import 'package:drink_bank/Page/gemini.dart'; // Import ChatBox for Gemini chat functionality
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drinks Bank', // App title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set the primary color to blue
        visualDensity:
            VisualDensity
                .adaptivePlatformDensity, // Adjust UI density for different platforms
        textTheme: GoogleFonts.latoTextTheme(
          // Use Lato font as the global text theme
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(), // Set HomePage as the default screen
      routes: {
        '/add': (context) => AddDrinkPage(), // Route for AddDrinkPage
        '/chat': (context) => GeminiPage(), // Route for ChatBox
      },
    );
  }
}
