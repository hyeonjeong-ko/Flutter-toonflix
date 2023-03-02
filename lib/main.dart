import 'package:flutter/material.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // int counter = 0;
  List<int> numbers = [];
  bool showTitle = true;
  void toggleTitle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  void onClicked() {
    // setState 함수 안에서 데이터를 변경=>flutter는 build method를 다시 실행
    setState(() {
      //counter = counter + 1;
      numbers.add(numbers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
              titleLarge: TextStyle(
            color: Colors.red,
          )),
        ),
        home: Scaffold(
          backgroundColor: const Color(0xFFF4EDDB),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showTitle ? const MyLargeTitle() : const Text('nothing'),
                IconButton(
                    onPressed: toggleTitle,
                    icon: const Icon(Icons.remove_red_eye))
              ],
            ),
          ),
        ));
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  int count = 0;

  // 부모 요소 의존 데이터 초기화
  @override
  void initState() {
    super.initState();
  }

  // 위젯이 스크린에서 제거될때 호출되는 메서드
  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  // context는 Text 이전에 있는 모든 상위 요소들에 대한 정보
  @override
  Widget build(BuildContext context) {
    return Text(
      'My Large Title',
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context).textTheme.titleLarge!.color,
      ),
    );
  }
}
