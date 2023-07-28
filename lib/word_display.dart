import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spanish_word/word.dart';
import 'package:flutter_tts/flutter_tts.dart';

class WordDisplay extends StatelessWidget {
  final Word word;
  final FlutterTts flutterTts = FlutterTts();

  WordDisplay({super.key, required this.word});
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
              Text(
                "주제 : ${word.mainTitle ?? 'N/A'}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              SizedBox(height: 15),
              Text(
                "소주제 : ${word.subTitle ?? 'N/A'}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 15),
              Text(
                "영단어 : ${word.englishWord ?? 'N/A'}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                "한국어 : ${word.koreanWord ?? 'N/A'}",
                style: TextStyle(fontSize: 16),
              ),
              // CachedNetworkImage(
              //   imageUrl: word.imageUrl,
              //   placeholder: (context, url) => CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
              // SizedBox(height: 10),
              // Text(word.exampleSentence),
              // SizedBox(height: 10),
              // Text(word.sentenceTranslation),
            ],
          ),
        ),
      ),
    );
  }
}
