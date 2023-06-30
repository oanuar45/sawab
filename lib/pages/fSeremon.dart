import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

class FSeremon extends StatefulWidget {
  const FSeremon({super.key});

  @override
  State<FSeremon> createState() => _FSeremonState();
}

class _FSeremonState extends State<FSeremon> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _controller2;
  late final AnimationController _controller3;
  late String assetName;
  late Widget svgIcon;
  // https://www.alislam.org/
  final url_1 = MySite(host: 'www.alislam.org', path: '/');
  bool _isElevated = false;

  Future<void> _launchURL(SitePath url) async {
    final Uri uri = Uri(scheme: "https", host: url.host, path: url.path);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Не удается открыть $uri";
    }
  }

  @override
  void initState() {
    super.initState();
    assetName = 'lib/assets/images/Belyi_Minaret.png';
    svgIcon = SvgPicture.asset(
      assetName,
      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
    );

    _controller = AnimationController(
      vsync: this,
      value: 0.2,
      duration: const Duration(seconds: 17),
      upperBound: 1,
      lowerBound: -1,
    )..repeat(reverse: false);

    _controller2 = AnimationController(
      vsync: this,
      value: 0.1,
      duration: const Duration(seconds: 19),
      upperBound: 1,
      lowerBound: -1,
    )..repeat(reverse: false);

    _controller3 = AnimationController(
      vsync: this,
      value: 0,
      duration: Duration(seconds: 21),
      upperBound: 1,
      lowerBound: -1,
    )..repeat(reverse: false);
  }

  @override
  dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.topCenter,
          //fit: StackFit.loose,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ClipPath(
                  clipper: DrawClip(_controller.value),
                  child: Container(
                    height: size.height * 0.75,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Color.fromARGB(170, 0, 150, 135), Color.fromARGB(85, 100, 255, 219)],
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ClipPath(
                  clipper: DrawClip(_controller2.value),
                  child: Container(
                    height: size.height * 0.74,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Color.fromARGB(170, 0, 150, 135), Color.fromARGB(170, 100, 255, 219)],
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ClipPath(
                  clipper: DrawClip(_controller3.value),
                  child: Container(
                    height: size.height * 0.73,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        // colors: [Colors.teal, Colors.tealAccent],
                        colors: [
                          Color.fromARGB(255, 0, 150, 135),
                          Color.fromARGB(150, 45, 192, 177),
                          Color.fromARGB(150, 100, 255, 219),
                          Color.fromARGB(255, 255, 255, 255),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 150),
              // child: svgIcon,
              child: Image.asset('lib/assets/images/Belyi_Minaret.png'),
              // child:  Padding(
              //   padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              //   child: Image.asset('lib/assets/images/LoveForAllHatredForNone.jpg'),
              // ),,
            ),
            Container(
              padding: const EdgeInsets.only(top: 350),
              child: const Text(
                'www.Al-Islam.org',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              _isElevated = !_isElevated;

              Future.delayed(const Duration(milliseconds: 700), () {
                _launchURL(url_1);
                // setState(
                //   () {},
                // );
              });
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 250,
            height: 63,
            onEnd: () {
              setState(() {
                _isElevated = false;
              });
            },
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: _isElevated
                    ? null
                    : [
                        const BoxShadow(
                          color: Colors.grey,
                          offset: Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: Colors.white10,
                          offset: Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        )
                      ]),
            child: const Padding(
              padding: EdgeInsets.only(top: 23),
              child: Text(
                'Официальный Сайт',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        // Text(
        //   'Text 2345',
        //   style: TextStyle(fontSize: 16),
        // ),
      ],
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);

  @override
  Path getClip(Size size) {
    print(move);
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter = size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    //
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
//
    path.quadraticBezierTo(xCenter, yCenter, size.height, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

abstract class SitePath {
  String host = '';
  String path = '';
}

class MySite implements SitePath {
  @override
  String host = '';
  @override
  String path = '';
  MySite({this.host = '', this.path = ''});
}


/*
        // Container(
        //   // padding: EdgeInsets.only(top: 0),
        //   child: TextButton(
        //     child: const Text(
        //       'Сайт',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         color: Colors.teal,
        //         fontSize: 19,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     onPressed: () => _launchURL(url_1),
        //   ),
        // ),
*/