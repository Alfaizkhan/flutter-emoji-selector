import 'dart:convert';
import 'dart:math';

import 'package:emoji_selector/emoji_selector.dart';
import 'package:emoji_selector/src/category.dart';
import 'package:emoji_selector/src/category_icon.dart';
import 'package:emoji_selector/src/category_selector.dart';
import 'package:emoji_selector/src/emoji_internal_data.dart';
import 'package:emoji_selector/src/emoji_page.dart';
import 'package:emoji_selector/src/group.dart';
import 'package:emoji_selector/src/skin_tone_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class EmojiSelector extends StatefulWidget {
  final int columns;
  final int rows;
  final EdgeInsets padding;
  final bool withTitle;
  final Function(EmojiData) onSelected;

  const EmojiSelector({
    Key? key,
    this.columns = 10,
    this.rows = 5,
    this.padding = EdgeInsets.zero,
    this.withTitle = true,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmojiSelectorState();
}

class _EmojiSelectorState extends State<EmojiSelector> {
  TextEditingController _controller = TextEditingController();
  Category selectedCategory = Category.smileys;
  List<EmojiInternalData> _emojiSearch = [];

  final List<EmojiInternalData> _emojis = [];
  final Map<Category, Group> _groups = {
    Category.smileys: Group(
      Category.smileys,
      CategoryIcons.smileyIcon,
      'smileys & People',
      ['smileys & Emotion', 'People & Body'],
    ),
    Category.animals: Group(
      Category.animals,
      CategoryIcons.animalIcon,
      'Animals & Nature',
      ['Animals & Nature'],
    ),
    Category.foods: Group(
      Category.foods,
      CategoryIcons.foodIcon,
      'Food & Drink',
      ['Food & Drink'],
    ),
    Category.activities: Group(
      Category.activities,
      CategoryIcons.activityIcon,
      'Activity',
      ['Activities'],
    ),
    Category.travel: Group(
      Category.travel,
      CategoryIcons.travelIcon,
      'Travel & Places',
      ['Travel & Places'],
    ),
    Category.objects: Group(
      Category.objects,
      CategoryIcons.objectIcon,
      'Objects',
      ['Objects'],
    ),
    Category.symbols: Group(
      Category.symbols,
      CategoryIcons.symbolIcon,
      'Symbols',
      ['Symbols'],
    ),
    Category.flags: Group(
      Category.flags,
      CategoryIcons.flagIcon,
      'Flags',
      ['Flags'],
    ),
  };
  List<Category> order = [
    Category.smileys,
    Category.animals,
    Category.foods,
    Category.activities,
    Category.travel,
    Category.objects,
    Category.symbols,
    Category.flags,
  ];

  int _skin = 0;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    loadEmoji(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return Container();

    int smileysNum = _groups[Category.smileys]!.pages.length;
    int animalsNum = _groups[Category.animals]!.pages.length;
    int foodsNum = _groups[Category.foods]!.pages.length;
    int activitiesNum = _groups[Category.activities]!.pages.length;
    int travelNum = _groups[Category.travel]!.pages.length;
    int objectsNum = _groups[Category.objects]!.pages.length;
    int symbolsNum = _groups[Category.symbols]!.pages.length;
    int flagsNum = _groups[Category.flags]!.pages.length;

    PageController pageController;
    switch (selectedCategory) {
      case Category.smileys:
        pageController = PageController(initialPage: 0);
        break;
      case Category.animals:
        pageController = PageController(initialPage: smileysNum);
        break;
      case Category.foods:
        pageController = PageController(initialPage: smileysNum + animalsNum);
        break;
      case Category.activities:
        pageController =
            PageController(initialPage: smileysNum + animalsNum + foodsNum);
        break;
      case Category.travel:
        pageController = PageController(
            initialPage: smileysNum + animalsNum + foodsNum + activitiesNum);
        break;
      case Category.objects:
        pageController = PageController(
            initialPage:
                smileysNum + animalsNum + foodsNum + activitiesNum + travelNum);
        break;
      case Category.symbols:
        pageController = PageController(
            initialPage: smileysNum +
                animalsNum +
                foodsNum +
                activitiesNum +
                travelNum +
                objectsNum);
        break;
      case Category.flags:
        pageController = PageController(
            initialPage: smileysNum +
                animalsNum +
                foodsNum +
                activitiesNum +
                travelNum +
                objectsNum +
                symbolsNum);
        break;
      default:
        pageController = PageController(initialPage: 0);
        break;
    }
    pageController.addListener(() {
      setState(() {});
    });

    List<Widget> pages = [];
    List<Widget> selectors = [];
    Group selectedGroup = _groups[selectedCategory]!;
    int index = 0;
    for (Category category in _groups.keys) {
      Group group = _groups[category]!;
      pages.addAll(group.pages.map((e) => EmojiPage(
            rows: widget.rows,
            columns: widget.columns,
            skin: _skin,
            emojis: e,
            onSelected: (internalData) {
              EmojiData emoji = EmojiData(
                id: internalData.id,
                name: internalData.name,
                unified: internalData.unifiedForSkin(_skin),
                char: internalData.charForSkin(_skin),
                category: internalData.category,
                skin: _skin,
              );
              widget.onSelected(emoji);
            },
          )));
      int current = index;
      selectors.add(
        CategorySelector(
          icon: group.icon,
          selected: selectedCategory == group.category,
          onSelected: () {
            pageController.jumpToPage(current);
          },
        ),
      );
      index += group.pages.length;
    }
    selectors.add(
      SkinToneSelector(onSkinChanged: (skin) {
        setState(() {
          _skin = skin;
        });
      }),
    );

    return Container(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 32.0,
            child: TextField(
              controller: _controller,
              onChanged: searchEmoji,
              cursorColor: Colors.grey,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                hintText: 'Search Emoji',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                prefixIcon: Container(
                  child: Icon(Icons.search),
                  width: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          if (widget.withTitle)
            Text(
              selectedGroup.title.toUpperCase(),
              style: TextStyle(fontSize: 12),
            ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.width / widget.columns) *
                widget.rows,
            child: (_emojiSearch.isNotEmpty && _controller.text.isNotEmpty)
                ? EmojiPage(
                    rows: widget.rows,
                    columns: widget.columns,
                    skin: _skin,
                    emojis: _emojiSearch,
                    onSelected: (internalData) {
                      EmojiData emoji = EmojiData(
                        id: internalData.id,
                        name: internalData.name,
                        unified: internalData.unifiedForSkin(_skin),
                        char: internalData.charForSkin(_skin),
                        category: internalData.category,
                        skin: _skin,
                      );
                      widget.onSelected(emoji);
                    },
                  )
                : PageView(
                    pageSnapping: true,
                    controller: pageController,
                    onPageChanged: (index) {
                      if (index < smileysNum) {
                        selectedCategory = Category.smileys;
                      } else if (index < smileysNum + animalsNum) {
                        selectedCategory = Category.animals;
                      } else if (index < smileysNum + animalsNum + foodsNum) {
                        selectedCategory = Category.foods;
                      } else if (index <
                          smileysNum + animalsNum + foodsNum + activitiesNum) {
                        selectedCategory = Category.activities;
                      } else if (index <
                          smileysNum +
                              animalsNum +
                              foodsNum +
                              activitiesNum +
                              travelNum) {
                        selectedCategory = Category.travel;
                      } else if (index <
                          smileysNum +
                              animalsNum +
                              foodsNum +
                              activitiesNum +
                              travelNum +
                              objectsNum) {
                        selectedCategory = Category.objects;
                      } else if (index <
                          smileysNum +
                              animalsNum +
                              foodsNum +
                              activitiesNum +
                              travelNum +
                              objectsNum +
                              symbolsNum) {
                        selectedCategory = Category.symbols;
                      } else if (index <
                          smileysNum +
                              animalsNum +
                              foodsNum +
                              activitiesNum +
                              travelNum +
                              objectsNum +
                              symbolsNum +
                              flagsNum) {
                        selectedCategory = Category.flags;
                      }
                    },
                    children: pages,
                  ),
          ),
          if (_controller.text.isEmpty)
            SizedBox(
              /* Category PICKER */
              height: 50,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: selectors,
                ),
              ),
            ),
        ],
      ),
    );
  }

  loadEmoji(BuildContext context) async {
    const path = 'packages/emoji_selector/data/emoji.json';
    String data = await rootBundle.loadString(path);
    final emojiList = json.decode(data);
    for (var emojiJson in emojiList) {
      EmojiInternalData data = EmojiInternalData.fromJson(emojiJson);
      _emojis.add(data);
    }
    // Per Category, create pages
    for (Category category in order) {
      Group group = _groups[category]!;
      List<EmojiInternalData> categoryEmojis = [];
      for (String name in group.names) {
        List<EmojiInternalData> subName = _emojis
            .where((element) => element.category == name && element.hasApple!)
            .toList();
        subName.sort((lhs, rhs) => lhs.sortOrder!.compareTo(rhs.sortOrder!));
        categoryEmojis.addAll(subName);
      }

      // Create pages for that Category
      int num = (categoryEmojis.length / (widget.rows * widget.columns)).ceil();
      for (var i = 0; i < num; i++) {
        int start = widget.columns * widget.rows * i;
        int end =
            min(widget.columns * widget.rows * (i + 1), categoryEmojis.length);
        List<EmojiInternalData> pageEmojis = categoryEmojis.sublist(start, end);
        group.pages.add(pageEmojis);
      }
    }
    setState(() {
      _loaded = true;
    });
  }

  void searchEmoji(String text) {
    List<EmojiInternalData> newEmojis = _emojis.where((element) {
      return element.shortName!.toLowerCase().contains(text);
    }).toList();
    setState(() {
      _emojiSearch = newEmojis;
    });
  }
}
