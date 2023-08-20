import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// 저장된 단어 목록 보여주는 페이지
class CheckedWordPage extends StatefulWidget {
  @override
  _CheckedWordPageState createState() => _CheckedWordPageState();
}

class _CheckedWordPageState extends State<CheckedWordPage> {
  List words = [];

  @override
  void initState() {
    super.initState();
    _getCheckedWords(); // 저장된 단어들 가져오기
  }

  // 서버에서 저장된 단어들 가져오는 메소드
  _getCheckedWords() async {
    final response = await http.get(Uri.parse('http://192.168.219.104:8080/checked-word'));
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
      body: Column(
        children: [
          // 헤더 부분
          Container(
            color: Colors.grey[300], // 헤더 배경색
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('스페인어', textAlign: TextAlign.center)), // 헤더 제목
                Expanded(child: Text('영어', textAlign: TextAlign.center)),     // 헤더 제목
                Expanded(child: Text('한국어', textAlign: TextAlign.center)),   // 헤더 제목
              ],
            ),
          ),
          // 단어 목록 부분
          Expanded(
            child: ListView.separated(
              itemCount: words.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 2.0, // 구분선의 두께 변경
                color: Colors.grey, // 구분선의 색상 변경
              ), // 구분선
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(words[index]['spanishWord'], textAlign: TextAlign.center)), // 스페인어 단어
                      Expanded(child: Text(words[index]['englishWord'], textAlign: TextAlign.center)), // 영어 단어
                      Expanded(child: Text(words[index]['koreanWord'], textAlign: TextAlign.center)),  // 한국어 단어
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }




}
