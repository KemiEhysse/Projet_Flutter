import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/food_tag.dart';
import '../providers/food_provider.dart';
import '../models/meal.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. FOND : Image simulant la caméra
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              'https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=1000',
              fit: BoxFit.cover,
            ),
          ),

          // 2. OVERLAY : Étiquettes du Membre C
          const FoodTag(label: "Egg", top: 180, left: 100),
          const FoodTag(label: "Bread", top: 320, left: 200),

          // 3. BOUTON DE SCAN : Connexion au FoodProvider
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Aliments détectés !",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // AJOUT AU PROVIDER : On respecte les types 'int' du modèle
                      context.read<FoodProvider>().addMeal(
                        Meal(
                          name: "Scan : Egg & Bread",
                          calories: 320,
                          proteins: 16, // int pur
                          carbs: 30,    // int pur
                          fats: 10,     // int pur
                          time: "Scan", // Requis par le modèle
                        ),
                      );

                      // Message de confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Repas ajouté au Food Log !"),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    },
                    child: Container(
                      height: 80, width: 80,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt, color: Colors.orange, size: 40),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bouton retour
          Positioned(
            top: 50, left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}