import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late EmojiData emojiData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emojis Selector Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: Text(
              emojiData.id == null
                  ? 'No emoji selected'
                  : 'Selected Emoji: ${emojiData.char}',
              style: const TextStyle(
                color: Colors.black12,
                fontSize: 24,
                fontFamily: 'Apple Color Emoji',
              ),
            ),
          ),
          EmojiSelector(
            padding: const EdgeInsets.all(20),
            onSelected: (emoji) {
              setState(() {
                emojiData = emoji;
              });
            },
          ),
        ],
      ),
    );
  }
}
