import 'package:emoji_selector/src/category_icon.dart';
import 'package:flutter/material.dart';

/// Category selector
class CategorySelector extends StatelessWidget {
  final bool selected;
  final CategoryIcon icon;
  final Function() onSelected;

  const CategorySelector(
      {Key? key,
      required this.selected,
      required this.icon,
      required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 9,
      height: MediaQuery.of(context).size.width / 9,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          backgroundColor: selected ? Colors.black12 : Colors.transparent,
        ),
        child: Center(
          child: Icon(
            icon.icon,
            size: 22.0,
            color: selected ? icon.selectedColor : icon.color,
          ),
        ),
        onPressed: () {
          onSelected();
        },
      ),
    );
  }
}
