// A widget is defined using the category data (from category.dart) to be displayed on the categories_screen. This file does that task.

import 'package:flutter/material.dart';
import '../screens/meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.title, this.color, this.id);

  void _selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      }, // 'arguments' can take any object. It is designed to help in passing info between screens. Here, we've passed a map.
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
              color.withOpacity(0.30),
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
