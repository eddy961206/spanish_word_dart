import 'package:flutter/material.dart';
import 'package:spanish_word/word.dart';
import 'package:spanish_word/word_display.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word of the Day',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Word of the Day'),
        ),
        body: Center(
          child: WordFetchState(),
        ),
      ),
    );
  }
}

class WordFetchState extends StatefulWidget {
  WordFetchState({Key? key}) : super(key: key);

  @override
  _WordFetchStateState createState() => _WordFetchStateState();
}

class _WordFetchStateState extends State<WordFetchState> {
  late Future<Word> _futureWord;

  @override
  void initState() {
    super.initState();
    _futureWord = fetchWord();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Word>(
      future: _futureWord,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WordDisplay(word: snapshot.data!);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}