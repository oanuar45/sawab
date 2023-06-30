// Ниже код который делает Нажимаемой кнопку Сауаб-Share
// curved_navigation_bar.dart:
// // Selected button
// Positioned(
//    bottom: widget.height - 114.0,  // ORIG: bottom: widget.height - 105.0,

import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
// my files
import 'package:Sawab/pages/mainSawab.dart';
import 'package:Sawab/pages/fSeremon.dart';
// import 'package:Sawab/pages/anime.dart'; // Anime
import 'package:Sawab/pages/hRamadan.dart';
import 'package:Sawab/pages/aPrayer.dart';

//import 'package:sawab/sql_helper.dart';
// pearl color - Color.fromARGB(255, 255, 251, 245);
// const Color mainMenuColor = Color.fromARGB(255, 255, 251, 245);
final Color mainMenuColor = Colors.black.withOpacity(0);
const Color mainTextColor = Colors.white;
//
void main() {
  runApp(
    MultiProvider(
        providers: [
          Provider(create: (context) => mainMenuColor),
          // ChangeNotifierProvider(
          //   create: (context) => TestProvider(), // (siv: [-1, -1, -1, -1, -1, -1, -1], sms: false),
          // ),
          // class TestProvider with ChangeNotifier {} // стоял в самом внизу отдельно
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Comfortaa',
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const MyApp(),
        )),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 3; // Default main menu select index
  final List<int> shareMenu = [0, 1, 0, 1]; // 0 disable, 1 Enable Share WhatsApp etc.
  static const TextStyle _mainMenuStyle = TextStyle(
    color: mainTextColor, // Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.5,
  );
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  late ScreenshotController _ctrlScreenshot; // = ScreenshotController();

  final List<Widget> _pages = [
    // const Anime(),
    const FSeremon(),
    const APrayer(),
    const HRamadan(),
    const MainSawab(),
    // Screenshot(controller: _ctrlScreenshot, child: const MainSawab()),
  ];

  @override
  void initState() {
    _ctrlScreenshot = ScreenshotController();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  Future _navigateBottomBar(int index) async {
    // void _navigateBottomBar(int index) {
    // Future _navigateBottomBar(int index) async {

    print(' 10    index = ' + index.toString());
    print(' 20   _selectedIndex = ' + _selectedIndex.toString());
    if (index == _selectedIndex && shareMenu[_selectedIndex] == 1) {
      final image = await _ctrlScreenshot.capture();
      if (image == null) return;
      await saveAndShare(image);
    }
    if (index != _selectedIndex) {
      if (_selectedIndex == 1) {
        _pages[1] = widget; // clear Previous menu
      }
      if (index == 1) {
        _pages[1] = const APrayer(); // assign New menu
      }
// go new Menu
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // Future<String> saveImage(Uint8List bytes) async {
  //   await [Permission.storage].request();

  //   final time = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
  //   final name = 'screenshot_$time';
  //   // final result = await ImageGallerySaver.saveImage(bytes, name: name);
  //   final result = await SaverGallery.saveImage(bytes, name: name, androidExistNotSave: false);
  //   // return result['filePath'];
  //   print(result.toString());

  //   final temp = await getTemporaryDirectory();
  //   final path = '${temp.path}/image2.jpg';
  //   print('path 2 = ' + path);
  //   File(path).writeAsBytes(bytes);
  //   // await Share.shareFiles([path], text: 'images', subject: 'something to share');
  //   await Share.shareXFiles([XFile('$path')], text: 'something to share');

  //   return result.toString();
  // }

  Future saveAndShare(Uint8List bytes) async {
    // final directory = await getApplicationDocumentsDirectory();
    // final image = File('${directory.path}/flutter1.png');
    // //
    // image.writeAsBytes(bytes);
    // print('path 1 = ' + image.path.toString());
    // final text = 'Shared from Tester';
    // await Share.shareXFiles([XFile('$image.path')], text: text);
    // //await Share.shareXFiles([XFile('assets/flutter.png')], text: 'Great picture');
    //
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image2.jpg';
    print('path 2 = ' + path);
    File(path).writeAsBytes(bytes);
    // await Share.shareFiles([path], text: 'images', subject: 'something to share');
    await Share.shareXFiles([XFile('$path')], text: 'something to share');
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _ctrlScreenshot,
      child: Scaffold(
        body: _pages[_selectedIndex],
        // корректируем распределение и вывод
        // type:           BottomNavigationBarType.fixed,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _selectedIndex,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            CurvedNavigationBarItem(
              child: MainMenuIcon(
                index: 0,
                curIndex: _selectedIndex,
                shareMenu: shareMenu,
              ),
              label: 'Проповедь',
              labelStyle: _mainMenuStyle,
            ),
            CurvedNavigationBarItem(
              // h_plus_mobiledata Хадисы
              child: MainMenuIcon(
                index: 1,
                curIndex: _selectedIndex,
                shareMenu: shareMenu,
              ),
              label: 'Намаз',
              labelStyle: _mainMenuStyle,
            ),
            CurvedNavigationBarItem(
              // high_quality_outlined
              child: MainMenuIcon(
                index: 2,
                curIndex: _selectedIndex,
                shareMenu: shareMenu,
              ),
              label: 'Рамадан',
              labelStyle: _mainMenuStyle,
            ),
            CurvedNavigationBarItem(
              // child: Icon(Icons.check_circle_outline_outlined, color: Colors.white),
              child: MainMenuIcon(
                index: 3,
                curIndex: _selectedIndex,
                shareMenu: shareMenu,
              ),
              label: 'Сауаб',
              labelStyle: _mainMenuStyle,
            ),
          ],
          // color: Colors.green.shade300,
          // buttonBackgroundColor: Colors.green.shade700,
          color: Colors.teal,
          buttonBackgroundColor: Colors.lightBlueAccent,
          backgroundColor: mainMenuColor, //Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: _navigateBottomBar,
          // onTap: null,
          // onTap: ((value) async {
          //   print(' 1111     index = ' + value.toString());
          //   print(' 22222   _selectedIndex = ' + _selectedIndex.toString());
          //   _navigateBottomBar;
          //   // final image = await _ctrlScreenshot.capture();
          //   // if (image == null) return;
          //   // await saveAndShare(image);
          // }),

          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}

/*
class MainMenuIcon extends StatelessWidget {
  final int index;
  final int curIndex;
  final List<int> shareMenu;
  const MainMenuIcon({
    super.key,
    required this.index,
    required this.curIndex,
    required this.shareMenu,
  });

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0: // Проповедь
        if (index != curIndex) {
          return const Icon(Icons.contact_page_outlined, color: Colors.white);
        } else {
          if (shareMenu[index] != 1) {
            return const Icon(Icons.contact_page_outlined, color: Colors.amber);
          } else {
            return const Icon(Icons.share, color: Colors.amber);
          }
        }
      case 1: // Намаз
        if (index != curIndex) {
          return const Icon(Icons.schedule, color: Colors.white);
        } else {
          if (shareMenu[index] != 1) {
            return const Icon(Icons.schedule, color: Colors.amber);
          } else {
            return const Icon(Icons.share, color: Colors.amber);
          }
        }
      case 2: // Рамадан
        if (index != curIndex) {
          return const Icon(Icons.dark_mode, color: Colors.white);
        } else {
          if (shareMenu[index] != 1) {
            return const Icon(Icons.dark_mode, color: Colors.amber);
          } else {
            return const Icon(Icons.share, color: Colors.amber);
          }
        }
      case 3: // Сауаб
        if (index != curIndex) {
          return const Icon(Icons.check_circle_outline_outlined, color: Colors.white);
        } else {
          if (shareMenu[index] != 1) {
            return const Icon(Icons.check_circle_outline_outlined, color: Colors.amber);
          } else {
            return const Icon(Icons.share, color: Colors.amber);
          }
        }
      default:
        return const Icon(Icons.logo_dev, color: Colors.white);
    }
  }
}
*/

class MainMenuIcon extends StatelessWidget {
  final int index;
  final int curIndex;
  final List<int> shareMenu;

  const MainMenuIcon({
    Key? key,
    required this.index,
    required this.curIndex,
    required this.shareMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;

    switch (index) {
      case 0: // Проповедь
        iconData = Icons.contact_page_outlined;
        break;
      case 1: // Намаз
        iconData = Icons.schedule;
        break;
      case 2: // Рамадан
        iconData = Icons.dark_mode;
        break;
      case 3: // Сауаб
        iconData = Icons.check_circle_outline_outlined;
        break;
      default:
        iconData = Icons.logo_dev;
    }

    if (index == curIndex) {
      if (shareMenu[index] != 1) {
        iconColor = Colors.white;
      } else {
        iconColor = Colors.amber;
        iconData = Icons.share;
      }
    } else {
      iconColor = Colors.white;
    }

    return Icon(iconData, color: iconColor);
  }
}

// class Simp extends ChangeNotifier {
//   //Simp({required this.siv, required this.sms});
//   List<int> siv = [-1, -1, -1, -1, -1, -1, -1];
//   bool sms = false; // _sawabModMenuShow Отображать или Скрыть меню модификации сауабов

//   void sel() {
//     sms = !sms;
//     notifyListeners();
//   }

/*
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Simp(), //change builder to create
      child: Consumer<Simp>(
          builder: (context, provider, child) => Scaffold(
*/
/* SAMPLE set go page - CurvedNavigationBarState ::
              ElevatedButton(
                child: Text('Go To Page of index 1'),
                onPressed: () {
                  final CurvedNavigationBarState? navBarState =
                      _bottomNavigationKey.currentState;
                  navBarState?.setPage(2);
                },
              )

// */
