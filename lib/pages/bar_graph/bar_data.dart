import 'individual_bar.dart';

class BarData {
  //final double a0;
  // int arrSize = 0;
  List<double> arr = [0];
  BarData({required this.arr});
  List<InidividualBar> barData = [];

  void initBarData(/*int arrSize*/) {
    int maxarr = 0;
    barData = []; // обнуление
    if (arr.length < 31) {
      maxarr = arr.length;
    } else {
      maxarr = 31; // огрничиваем кол-во столбцов Bar
    }
    for (int i = 0; i < maxarr; i++) {
      barData.add(InidividualBar(x: i, y: arr[i]));

      //     barData.add( [InidividualBar(x: i, y: arr[i]) ]);
    }
  }
}


/*
import 'individual_bar.dart';

class BarData {
  final double a0;
  final double a1;
  final double a2;
  final double a3;
  final double a4;
  final double a5;
  final double a6;

  BarData({
    required this.a0,
    required this.a1,
    required this.a2,
    required this.a3,
    required this.a4,
    required this.a5,
    required this.a6,
  });

  List<InidividualBar> barData = [];
// init Bar
  void initBarData() {
    barData = [
      InidividualBar(x: 0, y: a0),
      InidividualBar(x: 1, y: a1),
      InidividualBar(x: 2, y: a2),
      InidividualBar(x: 3, y: a3),
      InidividualBar(x: 4, y: a4),
      InidividualBar(x: 5, y: a5),
      InidividualBar(x: 6, y: a6),
      //InidividualBar(x: 7, y: a6), OK rabotaet!
    ];
  }
}

// */