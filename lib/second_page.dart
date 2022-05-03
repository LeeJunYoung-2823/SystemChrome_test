import 'dart:async';

import 'package:flutter/material.dart';
import 'package:system_chrome_test/third_page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    print('second initstate');
    Future.delayed(Duration(milliseconds: 200), () {
      Navigator.of(context).popUntil(ModalRoute.withName("/"));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return ThirdPage();
      }));
    });
    super.initState();
  }

  @override
  void dispose() {
    print('second dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
