import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/meal_detail.dart';
import 'package:meal/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title = "",
  });

  final List<Meal> meals;
  final String title;

  void selectMeal(BuildContext context, Meal selectedMeal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetail(
          meal: selectedMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();

    Widget content = Scaffold(
      appBar: title == ""
          ? null
          : AppBar(
              title: Text(
                title,
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: meals.length,
          itemBuilder: (context, index) => MealItem(
            meal: meals[index],
            onSelectMeal: () {
              selectMeal(context, meals[index]);
            },
          ),
        ),
      ),
    );

    if (meals.isEmpty) {
      content = Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No meals Here.",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Try selecting another category.",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      );
    }

    return content;
  }
}
