// The data for a category is mapped to a widget to be displayed on the categories_screen. This file does that task.

import 'package:flutter/material.dart';
import 'meals_screen_file.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.title, this.color, this.id);

  void _selectCategory(BuildContext ctx) {
    // We need this ctx here coz the Navigator needs it to move between pages.
    // In execution it needs to be given the context of the build method below. And the way to get that into this method is to pass it as an argument.

    // Screens/pages in a flutter app work like a 'stack'.
    // Adding a new page - push.
    // Returning to the old page, by deleting the current page - pop.
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          // The builder function here takes a context as a parameter which we won't need. Hence (_)
          return MealsScreen(id, title);
          // Passing data via Contructor.
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(
          15), // Must match that of the Container below. (Not for syntax but for good design)
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // This colors property takes a list of colors which it uses to create the gradient
            colors: [
              color.withOpacity(0.75),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
