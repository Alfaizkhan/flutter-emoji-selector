# Emoji Selector

Emoji Selector is an emoji picker component for Flutter.

![Screenshot of emoji Selector](https://raw.githubusercontent.com/Alfaizkhan/flutter-emoji_selector/main/images/emoji_selector.png?raw=true)


## Getting Started

Declare dependency in your `pubspec.yaml`
```yaml
dependencies:
    emoji_selector: ^0.0.4
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
        return Container(
        height: 266,
        child: EmojiSelector(
            onSelected: (emoji) {
            Navigator.of(subcontext).pop(emoji);
            },
        ),
        );
    },
);
```
