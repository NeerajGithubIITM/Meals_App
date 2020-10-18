// This widget form the screen for all the meals to be displayed (under each category) when a category is clicked on.
import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class MealsScreen extends StatefulWidget {
  // Defining the route name var for the widget being pushed in the route.
  // Declared static so that the property can be accessed from anywhere without instantiating the class.
  // Also we can use hardcoded strings for the route names in the MaterialApp widget (definition) and the widget where it is called (usage). This is simply a less error prone approach.
  static const String routeName = '/meals-screen';

  final List<Meal> filteredMeals;

  MealsScreen(this.filteredMeals);

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadingDone = false;

  @override
  void initState() {
    super.initState();
    // All the initialisation work done by didChangeDependencies() below could have been done by initState also normally.
    // But it is impossible because of the first statement which refers to the context and initState runs 'too early' for that.
    // Though the context is available everywhere in the State class, initState() runs before we can even have a context in our widget.

  }

  @override
  void didChangeDependencies() {
    if (!_loadingDone) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.filteredMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadingDone = true;
    }
    super.didChangeDependencies();

    // We used didChangeDependencies() here because this function runs (after the context is created, but) before build runs for the first time and loads the list that we need.
    // We need to access that list in _removeMeal() for the extra feature and didChangeDependencies() seemed convenient.
    // Also, the gimmick with _loadingDone is needed because, unlike initState, this function runs multiple times and will reload the entire list everytime it runs.
    // And that undoes the work done by _removeMeal().
    // So we make it do nothing after running once.

    // Using didChangeDependencies() here isn't a requirement for the app's main purpose.
    // This is for the extra feature, which is temporarily deleting a meal from the list on clicking the 'delete' floating action button in the details page.
 
  }

  // This function was being used when the temporary deletion feature was active.
  
  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            // removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
