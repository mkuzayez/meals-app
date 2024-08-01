import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meal/widgets/meal_item_trait.dart';
import 'package:string_capitalize/string_capitalize.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function() onSelectMeal;

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(16)),
        //   ),
        //   child:

        SizedBox(
      height: 200,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 5,
        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: InkWell(
          onTap: onSelectMeal,
          splashColor: Theme.of(context).colorScheme.primary,
          hoverColor: Theme.of(context).primaryColor,
          child: Stack(
            children: [
              FadeInImage(
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          meal.title,
                          maxLines: 2,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MealItemTrait(
                                icon: Icons.schedule,
                                label: '${meal.duration} min'),
                            const SizedBox(
                              width: 16,
                            ),
                            MealItemTrait(
                              icon: Icons.label_important,
                              label:
                                  meal.complexity.name.capitalize().toString(),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            MealItemTrait(
                              icon: Icons.attach_money,
                              label: meal.affordability.name
                                  .capitalize()
                                  .toString(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    // );
  }
}
