import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:hello_webview/my_website.dart';
import 'splashScreen/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OrgCloudai",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySplashScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MySplashScreen()));
          },
          child: Text("Click Here"),
        ),
      ),
    );
  }
}
/*

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InAppWebView Demo',
      home: MySplashScreen(),
    );
  }
}

class PageViewCarousel extends StatefulWidget {
  @override
  _PageViewCarouselState createState() => _PageViewCarouselState();
}

class _PageViewCarouselState extends State<PageViewCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                Image.network(
                    'https://itrefaicloud.onrender.com/static/assets2/images/1.jpg'),
                Image.network(
                    'https://itrefaicloud.onrender.com/static/assets2/images/2.jpg'),
                Image.network(
                    'https://itrefaicloud.onrender.com/static/assets2/images/3.jpg'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor:
                        _currentPage == i ? Colors.blue : Colors.grey,
                  ),
                ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MySplashScreen()));
            },
            child: Text("Click Here"),
          ),
        ],
      ),
    );
  }
}
*/
