import 'package:flutter/material.dart';

class DailyChart extends StatelessWidget {
  final double consumed; // calories consommées
  final double target;   // objectif calories
  final double proteins;
  final double carbs;
  final double fats;

 const DailyChart({
    super.key, // ← super-parameter, plus besoin de le redéclarer
    required this.consumed,
    required this.target,
    required this.proteins,
    required this.carbs,
    required this.fats,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (consumed / target).clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 170,
              height: 170,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 12,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),

            // Texte au centre de la jauge
            Column(
              children: [
                Text(
                  (target - consumed).toStringAsFixed(0),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Remaining",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 15),

        // Lignes graphiques Proteins / Carbs / Fat (fake pour l'instant oh)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _MacroStat(label: "Protein", value: "${proteins.toStringAsFixed(0)}/100g", color: Colors.blue),
            _MacroStat(label: "Carbs", value: "${carbs.toStringAsFixed(0)}/250g", color: Colors.orange),
            _MacroStat(label: "Fat", value: "${fats.toStringAsFixed(0)}/67g", color: Colors.green),
          ],
        ),
      ],
    );
  }
}

class _MacroStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MacroStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 45,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text(value, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
