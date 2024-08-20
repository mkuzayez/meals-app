import 'package:flutter/material.dart';
import 'package:meal/screens/categories.dart';
import 'package:meal/screens/filters.dart';
import 'package:meal/screens/meals.dart';
import 'package:meal/widgets/drawer.dart';
import 'package:meal/providers/meals_provider.dart';
import 'package:meal/providers/favorites_provider.dart';
import 'package:meal/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final Map kInitialFilters = {
//   Filter.glutenFree: false,
//   Filter.lactosFree: false,
//   Filter.vegetarian: false,
//   Filter.vegan: false,
// };

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

int avtiveScreenIdx = 0;

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // void toggleMealsFavoriteStatus(Meal meal) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   if (!_favoriteMeals.contains(meal)) {
  //     setState(
  //       () {
  //         _favoriteMeals.add(meal);
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text("Marked as favorite"),
  //           ),
  //         );
  //       },
  //     );
  //   } else {
  //     setState(
  //       () {
  //         _favoriteMeals.remove(meal);
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text("Unmarked as favorite"),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }

  Future<void> selectScreen(String screen) async {
    ScaffoldMessenger.of(context).clearSnackBars();

    Navigator.of(context).pop();
    if (screen == "filters") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filterProvider);
    final availableMeals = meals.where(
      (meal) {
        if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (activeFilters[Filter.lactosFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (activeFilters[Filter.vegetarian]! && meal.isVegetarian) {
          return false;
        }
        if (activeFilters[Filter.vegan]! && meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();

    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final List<Widget> screens = [
      CategoriesScreen(
        availableMeals: availableMeals,
      ),
      // favorite screen
      MealsScreen(
        meals: favoriteMeals,
      ),
    ];

    return Scaffold(
      drawer: MainDrawer(
        onSelectScreens: selectScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        elevation: 20,
        useLegacyColorScheme: true,
        selectedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorite"),
        ],
        onTap: (idx) {
          setState(
            () {
              avtiveScreenIdx = idx;
            },
          );
        },
      ),
      body: screens[avtiveScreenIdx],
      appBar: AppBar(
        title: Text(
          "Meals_App v2",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
