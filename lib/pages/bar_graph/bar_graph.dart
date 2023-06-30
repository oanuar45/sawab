import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:Sawab/pages/bar_graph/bar_data.dart';

class MyBarGraph extends StatefulWidget {
  final List<double> arv;
  final List<String> art;
  const MyBarGraph({
    super.key,
    required this.arv,
    required this.art,
  });

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  // a0, a1,..a6
  BarData myBarData = BarData(arr: []);
  double a_width = 33; // def 33 - adaptive width Адаптивная толщина столбцов bar
  double a_font = 11; // def 19 - adaptive width Адаптивная толщина столбцов bar

  @override
  Widget build(BuildContext context) {
    myBarData = BarData(arr: widget.arv);
    myBarData.initBarData();
    // print('test !................................. test !');
    // print('widget.arv.length== ' + widget.arv.length.toString());
    setState(() {
      if (widget.arv.length < 6) {
        a_width = 39;
        a_font = 13;
      } else if (widget.arv.length < 11) {
        a_width = 27;
        a_font = 13;
      } else if (widget.arv.length < 16) {
        a_width = 19;
        a_font = 12;
      } else if (widget.arv.length < 21) {
        a_width = 13;
        a_font = 9;
      } else {
        a_width = 7;
        a_font = 6;
      }
    });

    return BarChart(BarChartData(
        maxY: 31, // max Y bar
        minY: 0,
        //backgroundColor: Colors.white,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles)),
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    // color: Colors.green[800],
                    // color: Colors.amber[900],

                    // rodStackItems: [
                    //   BarChartRodStackItem(0, 1, Colors.lightGreenAccent),
                    //   BarChartRodStackItem(1, 2, Colors.amberAccent),
                    //   BarChartRodStackItem(2, 3, Colors.lightGreenAccent),
                    //   BarChartRodStackItem(3, 4, Colors.amberAccent),
                    //   BarChartRodStackItem(4, 5, Colors.orangeAccent),
                    //   BarChartRodStackItem(5, 6, Colors.greenAccent),
                    //   BarChartRodStackItem(6, 7, Colors.deepOrange),
                    //   BarChartRodStackItem(7, 8, Colors.greenAccent),
                    //   BarChartRodStackItem(8, 9, Colors.deepOrangeAccent),
                    //   BarChartRodStackItem(9, 10, Colors.greenAccent),
                    //   BarChartRodStackItem(10, 11, Colors.amber),
                    //   BarChartRodStackItem(11, 12, Colors.amberAccent),
                    //   BarChartRodStackItem(12, 13, Colors.amber),
                    //   BarChartRodStackItem(13, 14, Colors.amberAccent),
                    //   BarChartRodStackItem(14, 15, Colors.amber),
                    //   BarChartRodStackItem(15, 16, Colors.amberAccent),
                    //   BarChartRodStackItem(16, 17, Colors.amber),
                    //   BarChartRodStackItem(17, 18, Colors.amberAccent),
                    //   BarChartRodStackItem(18, 19, Colors.amber),
                    //   BarChartRodStackItem(19, 20, Colors.amberAccent),
                    //   BarChartRodStackItem(20, 21, Colors.green),
                    //   BarChartRodStackItem(21, 22, Colors.greenAccent),
                    //   BarChartRodStackItem(22, 23, Colors.green),
                    //   BarChartRodStackItem(23, 24, Colors.greenAccent),
                    //   BarChartRodStackItem(24, 25, Colors.green),
                    //   BarChartRodStackItem(25, 26, Colors.greenAccent),
                    //   BarChartRodStackItem(26, 27, Colors.green),
                    //   BarChartRodStackItem(27, 28, Colors.greenAccent),
                    //   BarChartRodStackItem(28, 29, Colors.green),
                    //   BarChartRodStackItem(29, 30, Colors.greenAccent),
                    //   BarChartRodStackItem(30, 31, Colors.green),
                    //   BarChartRodStackItem(31, 51, Colors.greenAccent),
                    // ],

                    gradient: const LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: [
                        // Colors.amber.shade900,
                        // Colors.pink,
                        // Colors.pinkAccent,
                        // Colors.redAccent,
                        // Colors.deepOrange,
                        // Colors.deepOrangeAccent,
                        // Colors.amberAccent,
                        // Colors.limeAccent,
                        // Colors.white,
                        // Colors.lightGreenAccent,
                        // Colors.lightGreenAccent,
                        Colors.white,
                        Colors.tealAccent,
                        Colors.teal,

                        // Colors.lightBlueAccent,
                      ],
                    ),

                    width: a_width,
                    borderRadius: BorderRadius.circular(5),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 31,
                      color: Colors.grey.shade100,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
        barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.teal, // Color.fromARGB(255, 46, 49, 146),
          direction: TooltipDirection.bottom,
          tooltipPadding: const EdgeInsets.all(15.0),
        ))));
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Colors.teal,
      fontWeight: FontWeight.bold,
      fontSize: a_font,
    );

    Widget text;

    //text = Text(value.toInt().toString(), style: style);
    text = Text(widget.art[value.toInt()], style: style);

    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
}



/*

  Widget getBottomTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Colors.teal[800],
      fontWeight: FontWeight.bold,
      fontSize: a_font,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('ПХ', style: style);
        break;
      case 1:
        text = Text('ПП', style: style);
        break;
      case 2:
        text = Text('Т', style: style);
        break;
      case 3:
        text = Text('НН', style: style);
        break;
      case 4:
        text = Text('НО', style: style);
        break;
      case 5:
        text = Text('Т', style: style);
        break;
      case 6:
        text = Text('БП17', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
}


// */