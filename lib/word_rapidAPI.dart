// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
//
// Future<Word> fetchWord() async {
//   final response = await http.get(
//     Uri.parse('https://random-words5.p.rapidapi.com/getRandom'),
//     headers: <String, String>{
//       'X-RapidAPI-Key': dotenv.env['RAPIDAPI_KEY']!,
//       'X-RapidAPI-Host': dotenv.env['RAPIDAPI_HOST_RANDOM']!,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     // If the server returns a 200 OK response, parse the word
//     String englishWord = response.body;
//     print('영어단어 : $englishWord');
//
//     // Translate the English word to Korean using the DeepL API
//     final translationResponse = await http.post(
//       Uri.parse('https://deepl-translator.p.rapidapi.com/translate'),
//       headers: <String, String>{
//         'content-type': 'application/json',
//         'X-RapidAPI-Key': dotenv.env['RAPIDAPI_KEY']!,
//         'X-RapidAPI-Host': dotenv.env['RAPIDAPI_HOST_DEEPL']!, // Host for the DeepL API
//       },
//       body: jsonEncode({
//         "text": englishWord,
//         "source": "EN",
//         "target": "KO",
//       }),
//     );
//
//     if (translationResponse.statusCode == 200) {
//       // If the server returns a 200 OK response, parse the translation
//       Map<String, dynamic> translation = jsonDecode(translationResponse.body);
//       String koreanWord = translation['text'];
//       print('한국어 : $koreanWord');
//
//       // Return a Word object
//       return Word(spanish: "", english: englishWord, korean: koreanWord);
//     } else {
//       // If the server did not return a 200 OK response, then throw an exception.
//       throw Exception('Failed to translate word');
//     }
//   } else {
//     // If the server did not return a 200 OK response, then throw an exception.
//     throw Exception('Failed to fetch word');
//   }
// }
//
//
// class Word {
//   final String spanish;
//   final String korean;
//   final String english;
//   // final String imageUrl;
//   // final String exampleSentence;
//   // final String sentenceTranslation;
//
//   // Word({this.spanish, this.korean, this.english, this.imageUrl, this.exampleSentence, this.sentenceTranslation});
//   Word({required this.spanish, required this.korean, required this.english});
//
//   factory Word.fromJson(Map<String, dynamic> json) {
//     return Word(
//       spanish: json['spanish'],
//       korean: json['korean'],
//       english: json['english'],
//       // imageUrl: json['imageUrl'],
//       // exampleSentence: json['exampleSentence'],
//       // sentenceTranslation: json['sentenceTranslation'],
//     );
//   }
// }
