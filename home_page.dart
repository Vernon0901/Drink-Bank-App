import 'package:drink_bank_app/Page/add_drink_page.dart';
import 'package:flutter/material.dart';
import 'package:drink_bank_app/Components/drink_card.dart';
import 'package:drink_bank_app/Page/drink_description_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> drinks = [
    {
      'name': 'Mojito',
      'image':
          'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/mojito-cocktails-150961e.jpg',
      'description':
          'A refreshing Cuban cocktail made with white rum, sugar, lime juice, soda water, and fresh mint.',
    },
    {
      'name': 'Espresso Martini',
      'image':
          'https://images.unsplash.com/photo-1572442388796-11668a67e53d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      'description':
          'Coffee-flavored cocktail with vodka, espresso, and coffee liqueur.',
    },
  ];

  void _addDrink(Map<String, dynamic> newDrink) {
    setState(() => drinks.add(newDrink));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Drinks Bank',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8), // 8 logical pixels
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: drinks.length,
              itemBuilder:
                  (context, index) => GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    DrinkDetailPage(drink: drinks[index]),
                          ),
                        ),
                    child: DrinkCard(drink: drinks[index]),
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDrinkPage()),
                );
                if (result != null && result is Map<String, dynamic>) {
                  _addDrink(result);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text('Add New Drink', style: GoogleFonts.lato()),
            ),
          ),
        ],
      ),
    );
  }
}
