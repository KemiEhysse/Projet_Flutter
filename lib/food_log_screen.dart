import 'package:flutter/material.dart';

class FoodLogScreen extends StatelessWidget {
  const FoodLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text("Thu, 13 August", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today_outlined, color: Colors.black, size: 20), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildCalendarHeader(),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                // Exemple d'heure vide avec bouton +
                _buildEmptyTimeSlot("7 AM"),
                
                // Un repas enregistré
                _buildMealRow("8:15", "Green Burst Poached Egg", "315", "24g", "16g", "14g"),
                
                _buildEmptyTimeSlot("9 AM"),
                _buildEmptyTimeSlot("10 AM"),

                // Deuxième repas enregistré
                _buildMealRow("10:08", "Berry Crunch Morning Set", "362", "12g", "55g", "11g"),
                
                _buildMealRow("10:31", "Golden Caramel Custard", "268", "9g", "38g", "10g"),

                _buildEmptyTimeSlot("11 AM"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- LES COMPOSANTS (WIDGETS) ---

  // 1. Ligne pour une heure vide avec le petit +
  Widget _buildEmptyTimeSlot(String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 45,
            child: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          const Expanded(child: Divider(color: Color(0xFFF0F0F0))),
          const SizedBox(width: 10),
          const Icon(Icons.add, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  // 2. Ligne avec un repas (Carte)
  Widget _buildMealRow(String time, String title, String kcal, String p, String c, String f) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heure
        SizedBox(
          width: 45,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ),
        // Carte du repas
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                // Placeholder pour l'image (Rôle du Membre C)
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4EB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.restaurant, color: Colors.orange),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text("🔥 $kcal Kcal", style: const TextStyle(color: Colors.orange, fontSize: 11, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          _nutrientTag(p, Colors.blue),
                          _nutrientTag(c, Colors.orange),
                          _nutrientTag(f, Colors.green),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _nutrientTag(String val, Color col) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        children: [
          Icon(Icons.circle, size: 6, color: col),
          const SizedBox(width: 4),
          Text(val, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  // Calendrier horizontal (simplifié)
  Widget _buildCalendarHeader() {
    return Container(
      height: 80,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _dateTile("09", "Sun"),
          _dateTile("10", "Mon"),
          _dateTile("11", "Tue"),
          _dateTile("12", "Wed"),
          _dateTile("13", "Thu", isSelected: true),
          _dateTile("14", "Fri"),
        ],
      ),
    );
  }

  Widget _dateTile(String d, String l, {bool isSelected = false}) {
    return Container(
      width: 50,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(d, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black)),
          Text(l, style: TextStyle(fontSize: 10, color: isSelected ? Colors.white : Colors.grey)),
        ],
      ),
    );
  }
}