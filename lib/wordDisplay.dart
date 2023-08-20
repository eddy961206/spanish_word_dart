import 'package:flutter/material.dart';
import 'package:spanish_word/word.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

// 단어 정보를 보여주는 위젯
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

  // 단어 체크 토글 메소드
  Future<void> toggleCheck() async {
    final response = await http.post(
      Uri.parse('http://192.168.219.104:8080/toggle-word'),
      body: {'wordId': widget.word.wordId.toString(), 'isChecked': isChecked ? '0' : '1'},
    );  // , 'isChecked': isChecked ? '0' : '1' 이 부분은 지워도 될듯. isChecked를 api에서 안받음

    if (response.statusCode == 200) {
      print('토글됨');
      setState(() {
        isChecked = !isChecked; // 체크 상태를 토글
      });
    } else {
      print('토글안됨');
    }
  }

  // 텍스트 정보 보여주기
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

              // 주제
              _buildText('주제', widget.word.mainTitle, fontSize: 22, fontWeight: FontWeight.bold),

              // 소주제
              _buildText('소주제', widget.word.subTitle, fontSize: 20, fontWeight: FontWeight.bold),

              // 스페인어 단어
              Text(
                widget.word.spanishWord ?? 'N/A',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              // 단어 듣기 버튼
              IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () async {  // 사용자가 버튼을 클릭하면 읽어줍니다
                  await widget.flutterTts.setLanguage("es-ES");
                  await widget.flutterTts.speak(widget.word.spanishWord ?? '');
                },
              ),

              // 영어 단어
              _buildText('영단어', widget.word.englishWord),

              // 한국어 뜻
              _buildText('한국어', widget.word.koreanWord),

              // 체크 박스와 문구
              Row(
                children: [
                  IconButton(
                    icon: isChecked ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
                    onPressed: toggleCheck,
                  ),
                  Text(
                    isChecked ? '저장된 단어입니다' : '단어를 저장하려면 체크하세요',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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

