import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';


class DrawerContent extends StatelessWidget {
  // Generally, between using build methods and creating a new widget in the same file there is not much of a difference.
  // If the widget is using the theme or changing state or generally doing something to trigger execution of the build method, (using the theme falls under this category because if the theme changes, build() is called again)
  // then using a separate widget may be a better idea for optimisation (since the build() of the parent widget tree need not be called)
  // It doesn't apply for this builder function, but maybe for the one in meal_details_screen.dart i.e buildSectionTitle() which uses theme.
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking!!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            "Meals: Home Page",
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListTile(
            "Filters",
            Icons.settings,
            () {
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            },
          ),
          // pushReplacementNamed() replaces the current page with the new page instead of pushing it on top of the stack.
          // It prevents the stack from growing infinitely tall and creating memory problems. 
          // Note: Using replacement removes the back button (on the top left corner in the app bar) from the new page. 

        ],
      ),
    );
  }
}
