import 'package:flutter/material.dart';
import 'myHomePage.dart';


// 플러터 앱의 시작점입니다.
// MyApp 위젯을 루트로 하는 플러터 앱을 실행합니다.
// Future main() async {
//   runApp(MyApp());
// }  //  꼭 이렇게 main 함수에 비동기처리 안해도. 어차피 내부 위젯에서 비동기 처리해야

void main() => runApp(MyApp());

// const String apiEndpoint = 'http://192.168.219.104:8080';

// MyApp은 플러터 앱의 루트 위젯입니다.
// MaterialApp 위젯을 사용하여 기본 테마와 홈페이지를 설정합니다.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스페인 단어장', // 앱 타이틀 설정
      theme: ThemeData(     // 기본 테마 색상 설정
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


