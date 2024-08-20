import 'package:flutter/material.dart';
import 'package:meal/data/dummy_data.dart';
import 'package:meal/models/category.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/meals.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void selectCategory(BuildContext context, Category category) {
    final List<Meal> filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category
            .id)) // return the meal that contains category's ID in it's categories.
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: availableCategories.length,
        itemBuilder: (context, index) => InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            selectCategory(context, availableCategories[index]);
          },
          splashColor: Theme.of(context).colorScheme.primary,
          hoverColor: Theme.of(context).primaryColor,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(colors: [
                availableCategories[index].color.withOpacity(0.8),
                availableCategories[index].color.withOpacity(0.5)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                availableCategories[index].title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white70, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
