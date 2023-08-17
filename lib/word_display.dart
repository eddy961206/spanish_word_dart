import 'package:flutter/material.dart';
import 'package:spanish_word/word.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

class WordDisplay extends StatelessWidget {
  final Word word;
  final FlutterTts flutterTts = FlutterTts();

  WordDisplay({Key? key, required this.word}) : super(key: key);

  Future<void> checkWord() async {
    final response = await http.post(
      Uri.parse('http://192.168.219.101:8080/check-word'),
      body: {'wordId': word.wordId.toString()},
    );

    if (response.statusCode == 200) {
      print('단어가 성공적으로 체크되었습니다');
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
              _buildText('주제', word.mainTitle, fontSize: 22, fontWeight: FontWeight.bold),
              _buildText('소주제', word.subTitle, fontSize: 20, fontWeight: FontWeight.bold),
              Text(
                word.spanishWord ?? 'N/A',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () async {  // 사용자가 버튼을 클릭하면 읽어줍니다
                  await flutterTts.setLanguage("es-ES");
                  await flutterTts.speak(word.spanishWord ?? '');
                },
              ),
              _buildText('영단어', word.englishWord),
              _buildText('한국어', word.koreanWord),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: checkWord,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
