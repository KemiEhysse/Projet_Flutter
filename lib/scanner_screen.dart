import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/food_tag.dart';
import '../providers/food_provider.dart';
import '../models/meal.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  int _currentIndex = 0;
  double _flashOpacity = 0.0;

  final List<Map<String, dynamic>> _mockData = [
    {
      'name': 'Mixed Greens & Protein',
      'image': 'https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=1000',
      'cal': 507, 'prot': 33, 'carbs': 38, 'fats': 27,
      'tags': [const FoodTag(label: "Egg", top: 320, left: 100)]
    },
    {
      'name': 'Healthy Avocado',
      'image': 'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?q=80&w=1000',
      'cal': 420, 'prot': 12, 'carbs': 45, 'fats': 22,
      'tags': [const FoodTag(label: "Avocado", top: 250, left: 150)]
    },
  ];

  void _scanFood() async {
    final food = _mockData[_currentIndex];

    // 1. AJOUT AU PROVIDER
    context.read<FoodProvider>().addMeal(
      Meal(
        name: food['name'],
        calories: food['cal'],
        proteins: food['prot'],
        carbs: food['carbs'],
        fats: food['fats'],
        time: "Scan",
      ),
    );

    setState(() => _flashOpacity = 1.0);
    await Future.delayed(const Duration(milliseconds: 150));
    
    // Correction de l'async gap (avertissement bleu)
    if (!mounted) return; 

    setState(() {
      _flashOpacity = 0.0;
      _currentIndex = (_currentIndex + 1) % _mockData.length;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${food['name']} ajouté !"), backgroundColor: Colors.orange),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentFood = _mockData[_currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          // IMAGE DE FOND
          Positioned.fill(child: Image.network(currentFood['image'], fit: BoxFit.cover)),

          // VISEUR AVEC COINS (Résout l'erreur de référence)
          Center(
            child: SizedBox( // SizedBox ici est ok car il ne contient que des enfants
              width: 280,
              height: 280,
              child: Stack(
                children: [
                  _buildCorner(top: 0, left: 0, isTop: true, isLeft: true),
                  _buildCorner(top: 0, right: 0, isTop: true, isLeft: false),
                  _buildCorner(bottom: 0, left: 0, isTop: false, isLeft: true),
                  _buildCorner(bottom: 0, right: 0, isTop: false, isLeft: false),
                ],
              ),
            ),
          ),

          // TAGS DYNAMIQUES
          ...currentFood['tags'],

          // FLASH BLANC
          AnimatedOpacity(
            opacity: _flashOpacity,
            duration: const Duration(milliseconds: 200),
            child: Container(color: Colors.white),
          ),

          // BOUTON DE SCAN
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: GestureDetector(
                onTap: _scanFood,
                child: Container(
                  width: 280, height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text("SCAN ALIMENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour dessiner les coins (Corrigé et référencé)
  Widget _buildCorner({double? top, double? bottom, double? left, double? right, required bool isTop, required bool isLeft}) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          border: Border(
            top: isTop ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
            bottom: !isTop ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
            left: isLeft ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
            right: !isLeft ? const BorderSide(color: Colors.white, width: 4) : BorderSide.none,
          ),
        ),
      ),
    );
  }
}