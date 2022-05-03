import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  late Timer _timer;
  late PageController pageController;

  @override
  void initState() {
    print('third initstate');

    pageController = PageController(initialPage: 5);
    // 풀스크린 모드 (상단바, 하단바 없앰)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);

    // 10분 마다 자동 임시저장
    _timer = Timer.periodic(
      Duration(seconds: 600),
      (Timer t) {
        print('timer');
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    print('third dispose');
    _timer.cancel();
    // 풀스크린 해제 (상단바, 하단바 보이기)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
                child: Text('close'),
                onPressed: () async {
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
