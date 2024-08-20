import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal/models/meal.dart';

class FavoriteMealNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealNotifier() : super([]);

  bool toggleFavoriteMealStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state
          .where((m) => m.id != meal.id)
          .toList(); // if IDs are identical, return false, don't keep the meal in state
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealNotifier();
  },
);
