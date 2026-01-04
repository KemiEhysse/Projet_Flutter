import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
//Import 'foodlog.dart';
// Import 'scanner.dart';
//Import 'analytics.dart';
import 'providers/food_provider.dart';
import 'profile.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FoodProvider(),
      child: const DietApp(),
    ),
  ); 
}
  

class DietApp extends StatelessWidget {
  const DietApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Rôle : Définition de l'orange officiel pour tout le groupe
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B00),
          primary: const Color(0xFFFF6B00),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Emplacements pour les pages des Membres B, C et D
  final List<Widget> _pages = [
    const PageHome(),
    const Center(child: Text("Food Log")),
    const Center(child: Text("Scanner")),
    const Center(child: Text("Analytics")),
    const ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFF6B00),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history_outlined), label: 'Food Log'),
          BottomNavigationBarItem
            (icon: Icon(Icons.document_scanner_outlined, size: 30), label: 'Scanner'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Analytics'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),

    );
  }
}

  
