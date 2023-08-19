import 'package:flutter/material.dart';
import 'package:spanish_word/word.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

class WordDisplay extends StatefulWidget {
  final Word word;
  final FlutterTts flutterTts = FlutterTts();

  WordDisplay({Key? key, required this.word}) : super(key: key);

  @override
  _WordDisplayState createState() => _WordDisplayState();
}

class _WordDisplayState extends State<WordDisplay> {
  bool isChecked = false; // 체크 상태를 관리하는 변수. 이 부분은 initState에서 설정하도록 변경합니다.

  @override
  void initState() {
    super.initState();
    isChecked = widget.word.isChecked == 1; // DB에서 가져온 isChecked 값을 사용하여 초기화
  }

  Future<void> toggleCheck() async {
    final response = await http.post(
      Uri.parse('http://192.168.219.104:8080/check-word'),
      body: {'wordId': widget.word.wordId.toString(), 'isChecked': isChecked ? '0' : '1'},
    );

    if (response.statusCode == 200) {
      print('단어가 성공적으로 체크되었습니다');
      setState(() {
        isChecked = !isChecked; // 체크 상태를 토글
      });
    } else {
      print('단어 체크에 실패했습니다');
    }
  }

  Widget _buildText(String title, String? value, {double fontSize = 16, FontWeight fontWeight = FontWeight.normal}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$title: ${value ?? 'N/A'}",
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildText('주제', widget.word.mainTitle, fontSize: 22, fontWeight: FontWeight.bold),
              _buildText('소주제', widget.word.subTitle, fontSize: 20, fontWeight: FontWeight.bold),
              Text(
                widget.word.spanishWord ?? 'N/A',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () async {  // 사용자가 버튼을 클릭하면 읽어줍니다
                  await widget.flutterTts.setLanguage("es-ES");
                  await widget.flutterTts.speak(widget.word.spanishWord ?? '');
                },
              ),
              _buildText('영단어', widget.word.englishWord),
              _buildText('한국어', widget.word.koreanWord),
              Row( // 체크박스와 문구를 가지고 있는 행
                children: [
                  IconButton(
                    icon: isChecked ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank), // 체크 상태에 따라 아이콘 변경
                    onPressed: toggleCheck, // 체크 상태 토글
                  ),
                  Text( // 체크 상태에 따라 문구 변경
                    isChecked ? '저장된 단어입니다' : '단어를 저장하려면 체크하세요',
                    style: TextStyle(fontSize: 12, color: Colors.grey), // 안내 문구 스타일
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

