import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Analytics", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Empêche les erreurs de dépassement
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Weekly Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            // --- GRAPHIQUE ---
            Container(
              height: 200,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBar("Mon", 0.4),
                  _buildBar("Tue", 0.7),
                  _buildBar("Wed", 0.5),
                  _buildBar("Thu", 0.9), // Aujourd'hui
                  _buildBar("Fri", 0.3),
                  _buildBar("Sat", 0.6),
                  _buildBar("Sun", 0.4),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            const Text("Nutrients Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // --- CARTES DE STATISTIQUES ---
            Row(
              children: [
                _buildStatCard("Proteins", "72g", Colors.blue),
                const SizedBox(width: 15),
                _buildStatCard("Carbs", "145g", Colors.orange),
              ],
            ),
            const SizedBox(height: 15),
            _buildStatCard("Fats", "52g", Colors.green, fullWidth: true),
          ],
        ),
      ),
    );
  }

  // Widget pour une barre du graphique
  Widget _buildBar(String day, double percent) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: 140 * percent, // Hauteur proportionnelle
          decoration: BoxDecoration(
            color: day == "Thu" ? Colors.orange : Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  // Widget pour une carte de statistique
  Widget _buildStatCard(String title, String value, Color color, {bool fullWidth = false}) {
    return Expanded(
      flex: fullWidth ? 0 : 1,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}