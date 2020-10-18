// This widget form the screen for all the meals to be displayed (under each category) when a category is clicked on.
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;

  MealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: Text('Recipe!'),
      ),
    );
  }
}
