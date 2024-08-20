import 'package:flutter/material.dart';
import 'package:meal/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var activeFilters = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(),
      body:
          // PopScope(
          // canPop: true,
          // onPopInvoked: (didPop) async {
          //   if (didPop) {
          //     return;
          //   } else {
          //     // WidgetsBinding.instance.addPostFrameCallback(
          //     //   (_) {
          //     //     Navigator.of(context).pop(
          //     //       {
          //     //         Filter.glutenFree: isGlutenFree,
          //     //         Filter.lactosFree: isLactoseFree,
          //     //         Filter.vegetarian: isVegetarian,
          //     //         Filter.vegan: isVegan,
          //     //       },
          //     //     );
          //     //   },
          //     // );
          //     ref.read(filterProvider.notifier).setFilters({
          //       Filter.glutenFree: isGlutenFree,
          //       Filter.lactosFree: isLactoseFree,
          //       Filter.vegetarian: isVegetarian,
          //       Filter.vegan: isVegan
          //     });
          //   }
          // },
          SingleChildScrollView(
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                "Gluten-free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                "Exclude any non Guten-free meals",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              value: activeFilters[Filter.glutenFree]!,
              onChanged: (isChecked) {
                ref
                    .watch(filterProvider.notifier)
                    .setFilter(Filter.glutenFree, isChecked);
              },
            ),
            SwitchListTile(
              title: Text(
                "Lactos-free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                "Exclude any non Lactos-free meals",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              value: activeFilters[Filter.lactosFree]!,
              onChanged: (isChecked) {
                ref
                    .watch(filterProvider.notifier)
                    .setFilter(Filter.lactosFree, isChecked);
              },
            ),
            SwitchListTile(
              title: Text(
                "Vegetarian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                "Exclude any non vegetarian meals",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              value: activeFilters[Filter.vegetarian]!,
              onChanged: (isChecked) {
                ref
                    .watch(filterProvider.notifier)
                    .setFilter(Filter.vegetarian, isChecked);
              },
            ),
            SwitchListTile(
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                "Exclude any non vegan meals",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              value: activeFilters[Filter.vegan]!,
              onChanged: (isChecked) {
                ref
                    .watch(filterProvider.notifier)
                    .setFilter(Filter.vegan, isChecked);
              },
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
