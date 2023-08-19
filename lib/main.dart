import 'package:flutter/material.dart';
import 'package:spanish_word/word.dart';
import 'package:spanish_word/word_display.dart';

import 'checked_word_page.dart';

Future main() async {
  runApp(MyApp());
}
// const String apiEndpoint = 'http://192.168.219.104:8080';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스페인 단어장',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('스페인 단어장'),
        ),
        drawer: Drawer(
          child: Builder(
            builder: (BuildContext context) {
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text('메뉴'),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    title: Text('저장된 단어목록'),
                    onTap: () {
                      Navigator.of(context).pop(); // 메뉴를 닫습니다.
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckedWordPage()));
                    },
                  ),
                  // 다른 메뉴 아이템들을 이곳에 추가할 수 있습니다.
                ],
              );
            },
          ),
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

  void refreshWord() {
    setState(() {
      _futureWord = fetchWord();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: FutureBuilder<Word>(
            future: _futureWord,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return WordDisplay(word: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
        FloatingActionButton(
          onPressed: refreshWord,
          child: Icon(Icons.refresh),
        ),
      ],
    );
  }
}
