import 'package:flutter/material.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildImageHeader(context),
              _buildNutritionCard(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _buildImageHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/food.jpg'), 
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        Positioned(
          top: 20,
          left: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white24,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
       
        _buildFoodTag("Mushroom", top: 100, left: 80),
        _buildFoodTag("Bread", top: 80, right: 60),
        _buildFoodTag("Lettuce", top: 160, left: 140),
        _buildFoodTag("Egg", top: 250, left: 100),
        _buildFoodTag("Sausage", top: 220, right: 70),
      ],
    );
  }

  
  Widget _buildFoodTag(String label, {double? top, double? left, double? right, double? bottom}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24, width: 0.5),
            ),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
          const SizedBox(height: 4),
          const CircleAvatar(radius: 4, backgroundColor: Colors.white),
        ],
      ),
    );
  }

 
  Widget _buildNutritionCard() {
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
          _buildCategoryBadge(),
          const SizedBox(height: 12),
          const Text(
            "Mixed Greens & Protein Morning Plate with Bread",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(child: _buildNutrientItem("Calories", "507 Kcal", Icons.local_fire_department, Colors.orange)),
              Expanded(child: _buildNutrientItem("Protein", "33g", Icons.fitness_center, Colors.blue)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildNutrientItem("Carbs", "38g", Icons.bakery_dining, Colors.orangeAccent)),
              Expanded(child: _buildNutrientItem("Fat", "27g", Icons.opacity, Colors.green)),
            ],
          ),
          const SizedBox(height: 25),
          _buildHealthyScore(),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wb_sunny_outlined, size: 14, color: Colors.green),
          SizedBox(width: 4),
          Text("Breakfast", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildNutrientItem(String title, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildHealthyScore() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Healthy Score", style: TextStyle(fontWeight: FontWeight.w600)),
            Text("80%", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: 0.8,
          backgroundColor: Colors.grey.shade200,
          color: Colors.green,
          minHeight: 8,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }

  // Boutons du bas
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.orange),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text("Update Details", style: TextStyle(color: Colors.orange)),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
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
}