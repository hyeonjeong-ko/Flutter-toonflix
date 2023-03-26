import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon.dart';
import 'package:toonflix/services/api_service.dart';

import '../widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          title: const Text(
            "오늘의 웹툰",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: webtoons,
            // snapshot을 이용해 future의 상태를 알 수 있음.
            // widget이 future를 기다림. await할 필요X setState필요X isLoading필요X
            // Future를 만들고, FutureBuilder에 넣기마 하면 됨
            // FutureBuilder는 자기가 기다릴 future, builder funct를 받는다
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // 많은 양의 데이터를 연속적으로 보여주고 싶을때
                return Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    // Expanded ; 화면의 남는 공간을 차지하는 Widget
                    // ListView가 남는 공간을 채운다.
                    Expanded(child: makeList(snapshot))
                  ],
                );
              }
              return const Center(
                // 로딩중...
                child: CircularProgressIndicator(),
              );
            }));
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      // 구분자
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
