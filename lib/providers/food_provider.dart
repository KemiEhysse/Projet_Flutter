import 'package:flutter/material.dart';
import '../models/meal.dart';
class FoodProvider extends ChangeNotifier {
  final List<Meal> _meals = [];
  List<Meal> get meals => _meals;
   int get totalCalories {
    return _meals.fold(0, (sum,meal) => sum + meal.calories);
   }
   void addMeal(Meal meal) {
    _meals.add(meal);
    notifyListeners();
   }
}