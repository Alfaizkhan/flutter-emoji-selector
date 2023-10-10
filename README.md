<a href="https://www.buymeacoffee.com/imalfaizkhan" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>


# Emoji Selector

Emoji Selector is an emoji picker component for Flutter.

![Screenshot of emoji Selector](https://raw.githubusercontent.com/Alfaizkhan/flutter-emoji_selector/main/images/emoji_selector.png?raw=true)


## Getting Started

Declare dependency in your `pubspec.yaml`
```yaml
dependencies:
    emoji_selector: ^0.0.6
```

[Optional] If you need support for Plattfroms that don't have the `Apple Color Emoji` font installed (e.g. Linux, Web, ...), download Noto Emoji Font from https://github.com/googlefonts/noto-emoji) and add it to your `pubspec.yaml`:
```yaml
flutter:
  fonts:
    - family: Noto Emoji
      fonts:
        - asset: fonts/NotoEmoji/NotoEmoji.ttf
```

You can then easily embed the Emoji Selector Widget anywhere in your application:
```dart
EmojiSelector(
    onSelected: (emoji) {
        print('Selected emoji ${emoji.char}');
    },
),
```

You will receive a callback with an `EmojiData` object represented the emoji picked by the user.

```dart
class EmojiData {
  final String id;
  final String name;
  final String unified;
  final String char;
  final String category;
  final int skin;
}
```

When the emoji is qualified with a skin tone, both `unified` and `char` contains the qualifed values.

The `skin` parameter goes from 0 to 6, 0 representing no skin tone applied. 1 is then the lighter skin tone and 6 the darkest.

## How to use as a keyboard

You can use a modal sheet to simulate a keyboard.

```dart
return showModalBottomSheet(
    context: context,
    builder: (BuildContext subcontext) {
        return SizedBox(
        height: 256,
        child: EmojiSelector(
            onSelected: (emoji) {
            Navigator.of(subcontext).pop(emoji);
            },
        ),
        );
    },
);
```
