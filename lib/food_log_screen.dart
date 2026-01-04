import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/food_provider.dart';
import '../models/meal.dart'; 


class FoodLogScreen extends StatelessWidget {
  const FoodLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    String formattedDate = "${days[now.weekday - 1]}, ${now.day}";


    final foodProvider = context.watch<FoodProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: Text(
          formattedDate,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today_outlined, color: Colors.black, size: 20), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildCalendarHeader(now),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                // 1. Créneau vide pour tester l'ajout
                _buildEmptyTimeSlot("7 AM", context),
                
                // 2. BOUCLE DYNAMIQUE : On affiche chaque repas stocké dans le Provider
                if (foodProvider.meals.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Aucun repas enregistré pour le moment", 
                        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                    ),
                  )
                else
                  ...foodProvider.meals.map((meal) => 
                    _buildMealRow(
                      "Now", 
                      meal.name, 
                      meal.calories.toString(), 
                      "${meal.proteins.toStringAsFixed(0)}g", 
                      "${meal.carbs.toStringAsFixed(0)}g", 
                      "${meal.fats.toStringAsFixed(0)}g"
                    )
                  ),

                // 3. Autres créneaux vides pour le design
                _buildEmptyTimeSlot("9 AM", context),
                _buildEmptyTimeSlot("11 AM", context),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCalendarHeader(DateTime today) {
    List<String> daysName = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Container(
      height: 80,
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
             // Calcule les jours de la semaine (Lundi à Dimanche)
              DateTime firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));
              DateTime dayDate = firstDayOfWeek.add(Duration(days: index));
          
              bool isSelected = dayDate.day == today.day;

              return _dateTile(
                dayDate.day.toString(), 
                daysName[dayDate.weekday - 1], 
                isSelected: isSelected
              );
            }),
          ),
        ),
      ), 
    );
  }

  // --- COMPOSANTS ADAPTÉS À TON PROVIDER ---

  Widget _buildEmptyTimeSlot(String time, BuildContext context) {
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
          // INTERACTION : On utilise ta méthode addMeal
          GestureDetector(
            onTap: () {
              context.read<FoodProvider>().addMeal(
                Meal(
                  name: "Nouveau repas", 
                  calories: 200, 
                  proteins: 15.0,
                  carbs: 25.0,
                  fats: 8.0,
                  time: "Déjeuner",
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Repas ajouté !")),
              );
            },
            child: const Icon(Icons.add, color: Colors.orange, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildMealRow(String time, String title, String kcal, String p, String c, String f) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 45,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
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