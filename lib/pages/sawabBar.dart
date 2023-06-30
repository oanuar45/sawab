import 'package:flutter/material.dart';
import 'bar_graph/bar_graph.dart';

class SawabBar extends StatefulWidget {
  final List<double> arrv;
  final List<String> arrt;
  // late List<double> arrv = [];
  // late List<String> arrt = [];

  const SawabBar({super.key, required this.arrv, required this.arrt});

  @override
  State<SawabBar> createState() => _SawabBarState();
}

class _SawabBarState extends State<SawabBar> {
// class SawabBar extends StatefulWidget {
  late bool isLoading = true;
  final List<double> barArray = [14, 7, 15, 31, 19, 3, 21, 1];

  @override
  void initState() {
    super.initState();
  }

  void setBarData(BuildContext context) {}

//   @override
//   Widget build(BuildContext context) {
//     return MyBarGraph(
//       weeklySummary: weeklySummary,
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // print(' Sawab Bar IF isLoading...................');
      isLoading = false;
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return MyBarGraph(
        arv: widget.arrv,
        art: widget.arrt,
        //weeklySummary: widget.arrv,
      );
    }
  }
}



/*

import 'package:flutter/material.dart';
import 'bar_graph/bar_graph.dart';

class SawabBar extends StatefulWidget {
  const SawabBar({super.key});

  @override
  State<SawabBar> createState() => _SawabBarState();
}

class _SawabBarState extends State<SawabBar> {
  List<double> weeklySummary = [
    14,
    7,
    15,
    31,
    19,
    3,
    21,
  ];

  @override
  Widget build(BuildContext context) {
    return MyBarGraph(
      weeklySummary: weeklySummary,
    );
  }
}


// */