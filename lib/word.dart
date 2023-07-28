import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';



Future<Word> fetchWord() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/random-word'), // Spring Boot API URL
  );
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
    print('받아온 JSON: $json');
    try {
      // Create a Word object from the JSON.
      Word word = Word.fromJson(json);
      print('$word');
      // Return the Word object.
      return word;
    } catch (e) {
      print('JSON을 Word객체로 변환하지 못했습니다 : $e');
      throw Exception('단어를 JSON으로 변환하지 못했습니다..');
    }
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('서버로부터 단어를 가져오지 못했습니다..');
  }
}




class Word {
  final String mainTitle;
  final String? subTitle;
  final String spanishWord;
  final String? koreanWord;
  final String englishWord;
  // final String imageUrl;
  // final String exampleSentence;
  // final String sentenceTranslation;

  // Word({this.spanish, this.korean, this.english, this.imageUrl, this.exampleSentence, this.sentenceTranslation});
  Word({required this.mainTitle, this.subTitle, required this.spanishWord, this.koreanWord, required this.englishWord});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      mainTitle: json['main_title'],
      subTitle: json['sub_title'] as String?,
      spanishWord: json['spanish_word'],
      koreanWord: json['korean_word'] as String?,
      englishWord: json['english_word'],
      // imageUrl: json['imageUrl'],
      // exampleSentence: json['exampleSentence'],
      // sentenceTranslation: json['sentenceTranslation'],
    );
  }

  @override
  String toString() {
    return 'Word: {mainTitle: $mainTitle, subTitle: $subTitle, spanishWord: $spanishWord, koreanWord: $koreanWord, englishWord: $englishWord}';
  }
}