import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetail extends ConsumerWidget {
  const MealDetail({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleFavoriteMealStatus(meal);
            },
            icon: isFavorite
                ? const Icon(Icons.star)
                : const Icon(Icons.star_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                clipBehavior: Clip.hardEdge,
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Ingredients",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  "- $ingredient",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Steps",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              for (final step in meal.steps)
                Text(
                  "- $step",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
