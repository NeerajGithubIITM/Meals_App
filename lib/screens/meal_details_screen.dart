// The screen which gives the details of the meal clicked on.

import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const String routeName = '/meal-details-screen';

  final Function toggleFav;
  final Function isMealFav;

  MealDetailsScreen(this.toggleFav, this.isMealFav);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildListContainer(Widget child) {
    return Container(
      height: 150,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    // .firstWhere behaves similar to .where but it stops traversing the list when the func returns true for the first time.
    // Here obviously even .where would work. But .firstwhere saves some work.
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients Required :'),
            buildListContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  elevation: 4,
                  color: Theme.of(context).accentColor.withOpacity(0.6),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        selectedMeal.ingredients[index],
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps :'),
            buildListContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${(index + 1)}'),
                    ),
                    title: Text(
                      selectedMeal.steps[index],
                    ),
                  ),
                  Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFav(mealId) ? Icons.star: Icons.star_border,
        ),
        onPressed: () => toggleFav(mealId),

        // The floating action button was being used to implement a feature of temporarily deleting a meal from the meals screen.
        // The icon was set to delete. And there also was a small drama with the implementation of didChangeDependencies() in meals_screen
        // It is now being used to mark favorites.

        // onPressed: () {
        //   // The argument in pop can take any object and can be used to pass info to its parent page.
        //   Navigator.of(context).pop(mealId);
        // },
      ),
    );
  }
}
