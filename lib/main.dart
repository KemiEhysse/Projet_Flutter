import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'food_log_screen.dart';
// Import 'scanner.dart';
import 'analytics.dart';
import 'profile.dart';
import 'providers/food_provider.dart';

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

  // 2. MISE À JOUR DES PAGES (On remplace les textes par tes classes)
  final List<Widget> _pages = [
    const PageHome(),
    const FoodLogScreen(),
    const Center(child: Text("Scanner")),
    const AnalyticsScreen(),
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