import 'package:flutter/material.dart';

import './screens/meals_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // One can also use a model class instead of a map to get IDE autocomplete and type check etc. and avoid errors dur to typos
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _filteredMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  List<Meal> _filteredMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals =
      []; // This needs to go to favorites_screen. So its passed to TabsScreen() and forwarded from there.

  // This function below is an inefficient way to go about things as the entire build() in the main button is called just to update a list.
  // State management brother...
  void _toggleFav(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    if (existingIndex < 0) {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }
  // Both the above functions will be passed to the meal details screen where
  // the floating action button will be used to mark a meal as favorite.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline6: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: TabsScreen(),
      // You can skip the home: argument by using initial routes.
      initialRoute: '/', // default is '/' onli.
      routes: {
        // This be called a route table.
        '/': (ctx) => TabsScreen(_favoriteMeals),
        MealsScreen.routeName: (ctx) => MealsScreen(_filteredMeals),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(_toggleFav, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },

      // This setting makes sure that the app does make a sensible navigation even in unexpected circumstances.
      // In case the app encounters a named route call through Navigator.of(context).pushNamed to a route that hasn't been defined in the route table,
      // It carries out a navigation to the route returned by this function.
      // Usually not required in apps where such unexpected calls aren't likely to happen. Definitely not in this one.
      onGenerateRoute: (settings) {
        // Also, this function allows usage of the settings of the called route which can be used according to requirement.
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => TabsScreen(_favoriteMeals));
      },
      onUnknownRoute: (settings) {
        // This is used if the route isn't found on the route table or onGenerateRoute.
        // If flutter isn't able to diplay some page or the other with the route table/onGeneratedRoute,
        // it tries to use the route here as a last resort before throwing an error.
        // Usually is a good idea to display a generic home page/can't find page error display page etc.
        // Since this tries to make sure the app doesn't crash and something or the other is displayed (fallback),
        // it's a good practice to define a route in this argument.
        return MaterialPageRoute(builder: (ctx) => TabsScreen(_favoriteMeals));
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}
