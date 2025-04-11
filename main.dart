import 'package:flutter/material.dart'; // 就好像C++ 的stream，这边是叫package
import 'package:drink_bank_app/Page/home_page.dart'; // 导入 home page
import 'package:google_fonts/google_fonts.dart'; // 导入 Google Fonts
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
        textTheme: GoogleFonts.latoTextTheme(
          // Use Lato font as the global text theme
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(), // Set HomePage as the default screen// Route for AddDrinkPage
    );
  }
}
