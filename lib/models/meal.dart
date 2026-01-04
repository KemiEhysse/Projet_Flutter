class Meal {
  final String name;
  final int calories;
  final double proteins;
  final double carbs;
  final double fats;
  final String time; // petit-dej,déjeuner,diner


  Meal({
    required this.name,
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
    required this.time,
  });
}