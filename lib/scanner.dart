import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../models/meal.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  // Index pour changer d'aliment
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _foodData = [
    {
      'name': 'Mixed Greens & Protein',
      'image': 'assets/images/food.jpg',
      'cal': 507, 'prot': 33, 'carbs': 38, 'fats': 27,
      'category': 'Breakfast',
      'score': 0.8
    },
    {
      'name': 'Healthy Avocado Toast',
      'image': 'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?q=80&w=1000', 
      'cal': 420, 'prot': 12, 'carbs': 45, 'fats': 22,
      'category': 'Lunch',
      'score': 0.9
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentFood = _foodData[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildImageHeader(context, currentFood['image']),
              _buildNutritionCard(currentFood),
              _buildActionButtons(context, currentFood),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context, String imagePath) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imagePath.startsWith('http')
              ? NetworkImage(imagePath)
              : AssetImage(imagePath) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Bouton Retour
        Positioned(
          top: 20, left: 20,
          child: CircleAvatar(
            backgroundColor: Colors.black26,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        _buildFoodTag("Mushroom", top: 100, left: 80),
        _buildFoodTag("Egg", top: 220, left: 120),
      ],
    );
  }

  Widget _buildNutritionCard(Map<String, dynamic> food) {
    return Container(
      transform: Matrix4.translationValues(0, -30, 0),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryBadge(food['category']),
          const SizedBox(height: 12),
          Text(food['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildNutrientItem("Calories", "${food['cal']} Kcal", Icons.local_fire_department, Colors.orange)),
              Expanded(child: _buildNutrientItem("Protein", "${food['prot']}g", Icons.fitness_center, Colors.blue)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildNutrientItem("Carbs", "${food['carbs']}g", Icons.bakery_dining, Colors.orangeAccent)),
              Expanded(child: _buildNutrientItem("Fat", "${food['fats']}g", Icons.opacity, Colors.green)),
            ],
          ),
          const SizedBox(height: 20),
          _buildHealthyScore(food['score']),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Map<String, dynamic> food) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right:20, bottom: 30),
      child: Row(
        children: [
          // Bouton pour changer d'aliment (Simule un nouveau scan)
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _currentIndex = (_currentIndex + 1) % _foodData.length;
                });
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.orange),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text("Next Scan", style: TextStyle(color: Colors.orange)),
            ),
          ),
          const SizedBox(width: 15),
          // Bouton pour AJOUTER AU PROVIDER
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.read<FoodProvider>().addMeal(
                  Meal(
                    name: food['name'],
                    calories: food['cal'],
                    proteins: food['prot'].toDouble(),
                    carbs: food['carbs'].toDouble(),
                    fats: food['fats'].toDouble(),
                    time: "Now",
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${food['name']} ajouté !"), backgroundColor: Colors.orange),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text("Add to Food Log", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widgets de support (Badge, Tags, Score) ---
  Widget _buildCategoryBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildNutrientItem(String title, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade100), borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildHealthyScore(double score) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Healthy Score", style: TextStyle(fontWeight: FontWeight.w600)),
            Text("${(score * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: score, backgroundColor: Colors.grey.shade200, color: Colors.green, minHeight: 6, borderRadius: BorderRadius.circular(10)),
      ],
    );
  }

  Widget _buildFoodTag(String label, {double? top, double? left, double? right, double? bottom}) {
    return Positioned(
      top: top, left: left, right: right, bottom: bottom,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
          ),
          const CircleAvatar(radius: 3, backgroundColor: Colors.white),
        ],
      ),
    );
  }
}