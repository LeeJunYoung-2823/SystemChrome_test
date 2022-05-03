import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:system_chrome_test/menu_model.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuState>(
          create: (_) => MenuState(),
        ),
      ],
      child: MaterialApp(
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
      ),
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
    Provider.of<MenuState>(context, listen: false)
        .menuFetchData('menulist-new.json');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isNeedSafeArea = MediaQuery.of(context).viewPadding.top > 0;

    final Size size = MediaQuery.of(context).size; // 폰 size
    final double statusBarHeight = MediaQuery.of(context).padding.top; // 상단바 높이

    List<MenuList> menuList = Provider.of<MenuState>(context).menuList;

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
        drawer: _mainDrawer(statusBarHeight, menuList, context));
  }

  // Drawer
  Widget _mainDrawer(double statusBarHeight, List<MenuList> menuList,
      BuildContext buildContext) {
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight), // 상단바 높이 만큼 padding
      child: Drawer(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: menuList == null ? 0 : menuList.length,
            itemBuilder: (BuildContext context, int index) {
              var menuItem = menuList[index];

              bool isLoginMenu = menuItem.title == '로그인';
              bool isSignedIn = true;
              return ListTile(
                title:
                    Text(isLoginMenu && isSignedIn ? '로그아웃' : menuItem.title!),
                onTap: () {
                  //Main.printLog('ListTitle onTap');

                  Navigator.of(context).pop();
                  Provider.of<MenuState>(context, listen: false)
                      .menuValue(menuItem);
                  //Widget newPage = MenuPage();
                  if (isLoginMenu && !isSignedIn) {
                    //newPage = LoginPage();
                  } else if (menuItem.title!.contains('회원정보') && !isSignedIn) {
                    //newPage = LoginPage();
                  } else if (isLoginMenu && isSignedIn) {
                    showDialog(
                        context: buildContext,
                        builder: (_) {
                          return AlertDialog(
                            title: Text('로그아웃'),
                            content: Text('로그아웃 하시겠습니까?'),
                            actions: <Widget>[
                              MaterialButton(
                                child: Text('확인'),
                                onPressed: () {
                                  Navigator.of(buildContext).pop();
                                  // UserInfo().logOut(() {
                                  //   Main.printLog('loggedOut');
                                  //   Navigator.popAndPushNamed(
                                  //       buildContext, '/');
                                  // });
                                },
                              ),
                              MaterialButton(
                                child: Text('취소'),
                                onPressed: () {
                                  Navigator.of(buildContext).pop();
                                },
                              )
                            ],
                          );
                        });
                    return;
                  } else if (menuItem.type == 'cart') {
                    //final url = util.Util().urlWithDefaultParams(WEB_CART);
                    //goCart(url);
                    return;
                  } else if (menuItem.type == 'web') {
                    //newPage = WebViewPage(menuItem.action ?? '');
                  } else if (menuItem.type == 'qrcode') {
                    //newPage = QRCodePage();
                  }
                },
              );
            }),
      ),
    );
  }
}
