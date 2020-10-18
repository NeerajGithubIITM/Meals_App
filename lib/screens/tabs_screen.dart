// The basic screen which is displayed at first. This will contain both categories and favorites screens.

// There are 2 ways to display tabs on the screen
// 1. Bottom of the screen
// 2. Bottom of the AppBar

// This file implements the first method (The one in the code history has the 2nd method)

import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/drawer_content.dart';
import '../models/meal.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
    {
      'page': CategoriesScreen(),
      'title': 'Categories',
    },
    {
      'page': FavoritesScreen(widget.favoriteMeals),
      'title': 'My Favorites',
    },
  ];
    super.initState();

    // We had to use initState() here coz of the widget.favoriteMeals feature being used
    // We can't use that in the State class initially. But it can be used in the initState().
    // it = widget.favoriteMeals
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delicious Meals : ${_pages[_selectedPageIndex]['title']}'),
      ),
      body: _pages[_selectedPageIndex]['page'],

      // Adding a navigation drawer in this screen.
      drawer: DrawerContent(),

      // The property used to set up navigation tabs at the bottom of the screen
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColorDark,
        selectedFontSize: 12,
        unselectedFontSize: 16,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        // Since the action onTap is managed manually, we also need to manually tell BottomNavigationBar() which tab is currently selected.
        // Else, the above defined color coding won't reflect
        currentIndex: _selectedPageIndex,

        // A nice shifting motion can be set up using..
        // type: BottomNavigationBarType.shifting // default is .fixed
        // In this case, formatting like background color needs to be done for each item separately within
        // the BottomNavigationBarItem() widget.
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Category'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}

// Unlike DefaultTabController(), with BottomNavigationBar() we need to manually control what the tabs are going to display.
