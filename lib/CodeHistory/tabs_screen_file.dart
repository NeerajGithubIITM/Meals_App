// The basic screen which is displayed at first. This will contain both categories and favorites screens.

// There are 2 ways to display tabs on the screen
// 1. Bottom of the screen
// 2. Bottom of the AppBar

// This file implements the second method

import 'categories_screen_file.dart';
import '../screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Meal> _;
  @override
  Widget build(BuildContext context) {
    // To display tabs below the appbar, build needs to return a DefaultTabController() which has Scaffold as its child
    return DefaultTabController(
      length: 2, // No. of tabs.
      initialIndex: 0, // default is 0. Means initially, the first tab is displayed i.e 'categories' (here). CAn be set to 1 also to make it open with 'favorites'.
      child: Scaffold(

        // The Scaffold here sets the page for all the content that any of the tabs want to display.
        // So, none of the TabBarView children need to have a Scaffold.
        appBar: AppBar(
          title: Text('Delicious Meals'),
          bottom: TabBar(
            tabs: <Widget>[
              // 2 tabs since length above has been set to 2.
              Tab(icon: Icon(Icons.category), text: 'Categories'), // Note, text takes a String and not Text widget. 
              Tab(icon: Icon(Icons.star), text: 'Favorites'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CategoriesScreen(),
            FavoritesScreen(_),
            // The number and order of TabBar() tabs and TabBarView() children need to match.
          ],
        ),
      ),
    );
  }
}

// The DefaultTabController(), TabBar() and TabBarView() work together behind the screens to do what they do.