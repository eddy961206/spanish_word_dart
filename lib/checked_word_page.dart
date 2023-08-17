import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckedWordPage extends StatefulWidget {
  @override
  _CheckedWordPageState createState() => _CheckedWordPageState();
}

class _CheckedWordPageState extends State<CheckedWordPage> {
  List words = [];

  @override
  void initState() {
    super.initState();
    _getCheckedWords();
  }

  _getCheckedWords() async {
    final response = await http.get(Uri.parse('http://192.168.219.101:8080/checked-word'));
    if (response.statusCode == 200) {
      final List parsedList = json.decode(response.body);
      setState(() {
        words = parsedList;
        print('체크된 단어들 : $words'); // 서버에서 받은 데이터를 출력
      });
    } else {
      print('서버에서 단어를 가져오는 데 실패했습니다. 상태 코드: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('저장된 단어목록'),
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 항목 간에 공간을 균등하게 분배
              children: [
                Text(words[index]['spanishWord']), // 스페인어 단어
                Text(words[index]['englishWord']), // 영어 단어
                Text(words[index]['koreanWord']),  // 한국어 단어
              ],
            ),
          );
        },
      ),
    );
  }
}
