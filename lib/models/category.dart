// Template for a category

import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

// Only if all the properties are final, the constructor can be made const
// And this constructor must be made const since a const list is being declared in dummy_data.dart
  const Category({
    @required this.id,
    @required this.title,
    this.color,
  });
}

// Note: Here, the import of material.dart is necessary to be able to use Color class and the @required decorator.