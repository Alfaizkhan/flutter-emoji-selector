import 'package:flutter/material.dart';

class CategoryIcon {
  final IconData icon;
  final Color color;
  final Color selectedColor;

  const CategoryIcon({
    required this.icon,
    this.color = const Color.fromRGBO(211, 211, 211, 1),
    this.selectedColor = const Color.fromRGBO(178, 178, 178, 1),
  });
}

class CategoryIcons {
  static const CategoryIcon recommendationIcon =
      CategoryIcon(icon: Icons.search);

  static const CategoryIcon recentIcon = CategoryIcon(icon: Icons.access_time);

  static const CategoryIcon smileyIcon = CategoryIcon(icon: Icons.tag_faces);

  static const CategoryIcon peopleIcon = CategoryIcon(icon: Icons.person);

  static const CategoryIcon animalIcon = CategoryIcon(icon: Icons.pets);

  static const CategoryIcon foodIcon = CategoryIcon(icon: Icons.fastfood);

  static const CategoryIcon travelIcon =
      CategoryIcon(icon: Icons.location_city);

  static const CategoryIcon activityIcon =
      CategoryIcon(icon: Icons.directions_run);

  static const CategoryIcon objectIcon =
      CategoryIcon(icon: Icons.lightbulb_outline);

  static const CategoryIcon symbolIcon = CategoryIcon(icon: Icons.euro_symbol);

  static const CategoryIcon flagIcon = CategoryIcon(icon: Icons.flag);
}
