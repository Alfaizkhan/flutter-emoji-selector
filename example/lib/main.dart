import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Emoji Keyboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
      ),
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _emojiData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emojis'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              child: Text(
                _emojiData == null
                    ? 'No emoji selected'
                    : 'Selected ${_emojiData.char}',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Apple Color Emoji',
                ),
              ),
              padding: EdgeInsets.only(
                top: 30,
              ),
            ),
            EmojiSelector(
              onSelected: (emoji) {
                setState(() {
                  _emojiData = emoji;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
