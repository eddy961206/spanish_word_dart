import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


// 서버에서 랜덤 단어 가져오기
Future<Word> fetchWord() async {
  final response = await http.get(
    Uri.parse('http://192.168.219.104:8080/random-word'),
  );
  if (response.statusCode == 200) {
    // 서버에서 정상 response면 JSON decoding
    Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
    print('받아온 JSON: $json');
    try {
      // JSON을 Word 객체로 변환
      Word word = Word.fromJson(json);
      print('JSON을 변환한 word객체 : $word');
      return word;  // Word 객체 리턴
    } catch (e) {
      print('JSON을 Word객체로 변환하지 못했습니다 : $e');
      throw Exception('단어를 JSON으로 변환하지 못했습니다..');
    }
  } else {
    // response가 200이 아니면 에러 처리
    throw Exception('서버로부터 단어를 가져오지 못했습니다..');
  }
}

// Word 클래스 - 서버 응답 JSON을 객체로 매핑
class Word {
  final int wordId;
  final String mainTitle;
  final String? subTitle;
  final String spanishWord;
  final String? koreanWord;
  final String englishWord;
  final int isChecked;
  // final String imageUrl;
  // final String exampleSentence;
  // final String sentenceTranslation;

  // Word({this.spanish, this.korean, this.english, this.imageUrl, this.exampleSentence, this.sentenceTranslation});
  Word({required this.wordId, required this.mainTitle, this.subTitle,
    required this.spanishWord, this.koreanWord, required this.englishWord, required this.isChecked});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      wordId: json['wordId'],
      mainTitle: json['mainTitle'],
      subTitle: json['subTitle'] as String?,
      spanishWord: json['spanishWord'],
      koreanWord: json['koreanWord'] as String?,
      englishWord: json['englishWord'],
      isChecked: json['isChecked'],
      // imageUrl: json['imageUrl'],
      // exampleSentence: json['exampleSentence'],
      // sentenceTranslation: json['sentenceTranslation'],
    );
  }

  @override
  String toString() {
    return 'Word: {wordId: $wordId, mainTitle: $mainTitle, subTitle: $subTitle, '
        'spanishWord: $spanishWord, koreanWord: $koreanWord, englishWord: $englishWord, isChecked: $isChecked}';
  }
}
