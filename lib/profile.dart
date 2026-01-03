import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/food_provider.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final totalCalories = context.watch<FoodProvider>().totalCalories;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Profil"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section Utilisateur
          const Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFFF6B00), // Ton orange officiel
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text("Utilisateur DietApp", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 30),

          //Calories en temps reel
          Text("Objectifs du jour", style: TextStyle(fontWeight: FontWeight.bold, color:  Colors.grey)),
          ListTile(
            leading: const Icon(Icons.height, color: Color(0xFFFF6B00)),
            title: const Text("Calories consommées"),
            trailing: Text("$totalCalories kcal",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), 
            ),
          ),                
          const Divider(),

          // Section Informations
          const Text("Mes informations physiques", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const ListTile(
            leading: Icon(Icons.height, color: Color(0xFFFF6B00)),
            title: Text("Taille"),
            trailing: Text("175 cm"),
          ),
          const ListTile(
            leading: Icon(Icons.cake, color: Color(0xFFFF6B00)),
            title: Text("Âge"),
            trailing: Text("25 ans"),
          ),
          const Divider(),
          
          // Section Paramètres
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Se déconnecter", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}