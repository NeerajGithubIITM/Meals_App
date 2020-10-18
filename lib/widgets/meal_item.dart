// A widget is defined using the meal data (from meal.dart) to be displayed on the meals_screen. This file does that task.

import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/meal_details_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  // final Function removeItem;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.complexity,
    @required this.affordability,
    @required this.imageUrl,
    @required this.duration,
    // @required this.removeItem,
  });

  void _selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailsScreen.routeName,
      arguments: id,);
    // .then((result) {
    //   if(result!= null)
    //     removeItem(result);
    // });
    // pushNamed returns a Future object.
    // The function passed to .then is executed only when **the page pushed from here is popped** and it returns back to this page.
    // If pop() in the pushed page was given some value in the argument, that will be recieved in 'result' here.
  }

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectMeal(context),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // Card supports a shape argument to decide its shape. So we used RoundedRectangleBorder().
                  // Image does not have a shape property so this new widget ClipRRect() to clip the image to a rounded rect shape.
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // The Stack takes up the size of its biggest widget.
                  // Positioned() is a widget used to place a child of the Stack in a required location within the Stack's space.
                  Positioned(
                    bottom: 20, // 20 pixels from the bottom
                    right: 10,
                    child: Container(
                      // This container is to define a proper space so that the softwrap and overflow have a defined space to work with.
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black54,
                      ),
                      width: 300, // A little less than the image
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Text(
                        title,
                        style: TextStyle(
                          // backgroundColor: Colors.black54,
                          // U can do the above step instead of using background color for the container.
                          // But that will look like having highlighted the text with the assigned color.
                          // Container background color provides an even background color for the whole text.
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.schedule),
                        SizedBox(width: 6),
                        Text('$duration min'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.work),
                        SizedBox(width: 6),
                        Text(complexityText),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.attach_money),
                        SizedBox(width: 6),
                        Text(affordabilityText),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
