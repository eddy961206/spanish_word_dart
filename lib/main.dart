import 'package:flutter/material.dart';
import 'package:spanish_word/word.dart';
import 'package:spanish_word/word_display.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  runApp(MyApp());
}

// GlobalKey를 생성합니다.
final wordFetchStateKey = GlobalKey<_WordFetchStateState>();

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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // GlobalKey를 통해 WordFetchState의 상태를 가져와 refreshWord 메서드를 호출합니다.
                wordFetchStateKey.currentState!.refreshWord();
              },
            ),
          ],
        ),
        body: Center(
          // WordFetchState 위젯에 GlobalKey를 할당합니다.
          child: WordFetchState(key: wordFetchStateKey),
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

  // 새로고침 기능을 위한 메서드를 추가합니다.
  void refreshWord() {
    setState(() {
      _futureWord = fetchWord();
    });
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
