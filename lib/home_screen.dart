import 'package:flutter/material.dart';
import 'widgets/daily_chart.dart';
import 'package:provider/provider.dart';
import 'providers/food_provider.dart';


class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  String selectedTab = "Today";

  @override
  Widget build(BuildContext context) {
    final foodProvider = context.watch<FoodProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          

              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Good Morning, User",
                     style: TextStyle(
                       fontSize: 22,
                       fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      children: const [
                        Icon(Icons.notifications_outlined),
                        SizedBox(width: 12),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                        )
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 20),

                /// pour aligner today, weekly et monthly
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _tabButton("Today"),
                    _tabButton("Weekly"),
                    _tabButton("Monthly"),
                  ],
                ),

                const SizedBox(height: 20),

              
                if (selectedTab == "Today") ...[
                  const Text(
                    "Calories",
                   style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                    Center(
                      child: DailyChart(
                        consumed: foodProvider.totalCalories.toDouble(),
                        target: 2200,
                        proteins: foodProvider.totalProteins,
                        carbs: foodProvider.totalCarbs,
                        fats: foodProvider.totalFats,
                       ),
                    ),

                  const SizedBox(height: 30),

                   /// Contenu de losing weight goal
                  const Text(
                    "Losing Weight Goal",
                   style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _GoalWidget(
                        title: "Goal Weight",
                        value: 60,
                        target: 75,
                      ),
                      _GoalWidget(
                        title: "Goal Rate",
                        value: 1.2,
                        target: 2.0,
                      ),
                    ],
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text(
                        "$selectedTab View",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Les sections weekly et monthly
  Widget _tabButton(String label) {
    final bool active = selectedTab == label;

    return GestureDetector(
      onTap: () => setState(() => selectedTab = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

/// La section des goal 
class _GoalWidget extends StatelessWidget {
  final String title;
  final double value;
  final double target;

  const _GoalWidget({
    required this.title,
    required this.value,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (value / target).clamp(0.0, 1.0);

    return Column(
      children: [
        SizedBox(
          height: 120,
          width: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: progress,
                strokeWidth: 10,
                backgroundColor: Colors.grey.shade300,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.purple),
              ),
              Text(
                "$value",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
