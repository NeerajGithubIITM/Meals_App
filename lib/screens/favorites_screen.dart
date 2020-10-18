// Favorites screen.... what else??

import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You haven\'t added any favorites yet'),
      );
    }
    else{
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}

// This current set up has a small problem
// On marking a meal as favorite, and then going to the favorites page, it shows up there - good.
// But when we unmark that item as fav and return *directly* to the favs page, the change isn't reflected just yet!
// Only on going to some other page and returning to the favs page i.e on causing the favs page to be rebuilt, the change is seen, i.e the unfav'ed item is no more.
// This is because since the state is not managed in this widget, the build method is not called (hence no change is observed) on unfavoriting the meal.

// A quick but dirty fix would be to make this widget a stateful one and use a setState without any instructions to trigger build() whenever we want a reloading of the page.
// But bigger apps will need a more efficient / elegant management of this issue.
// More about this in State Management.