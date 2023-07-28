// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:spanish_word/word.dart';
//
// class WordDisplay extends StatelessWidget {
//   final Word word;
//
//   WordDisplay({super.key, required this.word});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: <Widget>[
//           Text(word.spanish),
//           Text("영단어 : ${word.english}"),
//           Text("한국어 : ${word.korean}"),
//           // CachedNetworkImage(
//           //   imageUrl: word.imageUrl,
//           //   placeholder: (context, url) => CircularProgressIndicator(),
//           //   errorWidget: (context, url, error) => Icon(Icons.error),
//           // ),
//           // Text(word.exampleSentence),
//           // Text(word.sentenceTranslation),
//         ],
//       ),
//     );
//   }
// }
