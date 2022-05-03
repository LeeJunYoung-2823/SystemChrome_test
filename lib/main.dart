import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_chrome_test/second_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => MyHomePage(title: 'Flutter Demo Home Page'),
      },
      initialRoute: '/',
      title: 'Flutter Demo',
      theme: ThemeData(
//          primaryColor: Color.fromARGB(255, 255, 84, 83),
          primaryColor: Colors.white,
          accentColor: Color.fromARGB(255, 255, 84, 83),
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue,
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ))),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isNeedSafeArea = MediaQuery.of(context).viewPadding.top > 0;

    final Size size = MediaQuery.of(context).size; // 폰 size
    final double statusBarHeight = MediaQuery.of(context).padding.top; // 상단바 높이

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.red),
          centerTitle: true,
          elevation: 0,
          title: Text(widget.title),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
                child: Text('button click'),
                onPressed: () async {
                  await Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return SecondPage();
                      }));
                })
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('로그인'),
                onTap: () {},
              );
            }),
      ),
    );
  }
}
