import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//import 'package:sawab/pages/mainsawab.dart';

class Simp extends ChangeNotifier {
  int itemSize; // SIZE of menu sawab Item List
  Simp([this.itemSize = 0]); // def 0
  //Simp({required this.siv, required this.sms});
  // _sawabItemNewVal новое значения сауабов 0-Не выделен, 1 выделен для модификации
  //List<int> siv = [0, 0, 0, 0, 0, 0, 0, 0];
  //late var siv = List<String>.filled(itemSize, '', growable: true);
  List<int> siv = [0]; // Select item 0=No, 1=Yes
  List<int> osiv = [0]; // Only Selected items 1=yes
  List<double> iarr = [0]; // array all item values
  bool sms = false; // _sawabModMenuShow show-hide меню +- сауабов
  bool sime = false; // sawab item menu edit - true Enabled, false Disabled

// dynamic change siv[] arr for new size setSivSize\_journal.length
  int setSiv(int setSivSize, int index) {
    if (setSivSize != siv.length) {
      // print('if...begin..........');
      // print('if... siv.length=' + siv.length.toString());
      final _newArr = List<int>.filled(setSivSize, 0, growable: true);
      for (int i = 0; i < setSivSize; i++) {
        _newArr[i] = (i < siv.length - 1 ? siv[i] : 0);
      }
      // print('if... _newArr.length=' + _newArr.length.toString());
      siv = List<int>.filled(setSivSize, 0, growable: true);
      for (int i = 0; i < setSivSize; i++) {
        siv[i] = _newArr[i];
      }
      // print('if... NEW siv.length=' + siv.length.toString());
      // print('if...end..........');
      //print('siv.length =' + siv.length.toString());
      //print('siv.0 =' + siv[index].toString());
      // ??? notifyListeners();
      //notifyListeners(); // for watch-reload widgets ???
    }
    return (siv[index] == 0 || siv.length == 0 ? 0 : siv[index]);
  }

// set siv[] arr all elements=0
  void setSivZero() {
    siv = List<int>.filled(siv.length, 0, growable: true);
  }

// save arr SIV[] to> OSIV[] only checked elements i \osiv.add(i);
  bool osiv_calc() {
    osiv = [];
    int _tab = 0; // def tabyldy 0
    for (int i = 0; i < siv.length; i++) {
      if (siv[i] == 1) {
        osiv.add(i); // save
        _tab = 1;
      }
    }
    if (osiv.length == 1) {
      sime = true; // Enable item Editor button
    } else {
      sime = false; // Disable item Editor button
    }
    if (_tab == 1) {
      return true;
    } else {
      return false;
    }
  }

  void sel() {
    sms = !sms;
    notifyListeners();
  }

  void calc(var index) {
    if (!sms) {
      // если подменю СКРЫТ
      sms = true; // то Показать подМеню
      siv[index] = 1; // fix на Показ
    } else {
      sms = false; //true = найден Выделенка, DEFAULT false Скрыть подМеню
      // если подменю ВИДЕН
      if (siv[index] > 0) {
        // если Выделена
        siv[index] = 0; // fix на Скрытие
        for (var i = 0; i < siv.length; i++) {
          if (siv[i] > 0) {
            // если Выделен
            sms = true; // Показать меню
            break;
          }
        }
      } else {
        // значит подменю НЕ выделен
        siv[index] = 1; // fix на Показ
        sms = true; // fix на Показ
      }
    }
    osiv_calc();
    notifyListeners(); // for watch-reload widgets
    // print("TEST start, index=" + siv[index].toString());
  }

  // void siaread(BuildContext context) {
  //   print('siaread == ' + context.read()._journals.length.toString());
  // }
}

// class GeneralsawabItem {}

// class Simp extends ChangeNotifier {
//   //Simp({required this.siv, required this.sms});
//   List<int> siv = [-1, -1, -1, -1, -1, -1, -1];
//   bool sms =
//       false; // _sawabModMenuShow Отображать или Скрыть меню модификации сауабов

//   void sel() {
//     sms = !sms;
//     notifyListeners();
//   }
// }

/*

ReorderableListView(
        header: const Text('This is the header!'),
        children: [
          for (final item in _myTiles)
            ListTile(
              key: ValueKey(item),
              title: Text('item #$item'),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {},
      ),
*/

// String to Number
//   int azzt = int.parse(_str.replaceAll(RegExp(r'[^0-9]'), ''));

// Dont do this: Error: Invalid radix-10 number :
// int newnum = int.parse(str);

// */
