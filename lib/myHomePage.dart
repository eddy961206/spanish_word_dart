import 'package:flutter/material.dart';
import 'package:spanish_word/word.dart';
import 'package:spanish_word/wordDisplay.dart';
import 'checkedWordPage.dart';


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(   // 홈페이지로 WordFetchState 위젯을 보여줍니다.
      appBar: AppBar(
        title: Text('스페인 단어장'),
      ),
      drawer: Drawer( // 드로어 메뉴 설정
        child: Builder(
          builder: (BuildContext context) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader( // 드로어 헤더
                  child: Text('메뉴'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(  // 드로어의 메뉴들 목록
                  title: Text('저장된 단어목록'),
                  onTap: () {
                    Navigator.of(context).pop(); // 드로어 메뉴 닫기
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CheckedWordPage())
                    );  // 저장된 단어목록 페이지로 이동
                  },
                ),
                // 다른 메뉴 아이템들을 이곳에 추가할 수 있습니다.
              ],
            );
          },
        ),
      ),
      body: Center( // 홈 화면
        child: WordFetchState(),
      ),
    );
  }
}

// 새 단어를 가져오고 보여주는 StatefulWidget
class WordFetchState extends StatefulWidget {
  WordFetchState({Key? key}) : super(key: key);

  @override
  _WordFetchStateState createState() => _WordFetchStateState();
}

class _WordFetchStateState extends State<WordFetchState> {
  // Future를 사용해 서버에서 단어 가져오기
  late Future<Word> _futureWord;

  @override
  void initState() {
    super.initState();
    _futureWord = fetchWord();
  }

  // 단어 새로고침
  void refreshWord() {
    setState(() {
      _futureWord = fetchWord();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded( // FutureBuilder로 서버에서 단어 받아오기
          child: FutureBuilder<Word>( // FutureBuilder :  비동기 작업의 결과를 기다리면서도 사용자에게 응답하는 UI를 제공
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
        FloatingActionButton( // 새로고침 버튼
          onPressed: refreshWord,
          child: Icon(Icons.refresh),
        ),
      ],
    );
  }
}