import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:Sawab/sql_helper.dart';
// my dart
import 'package:Sawab/core.dart';
import 'package:Sawab/pages/SawabItems.dart';
import 'package:Sawab/pages/SawabBar.dart';

// String _titleController = '';
// String _descriptionController = '';

class MainSawab extends StatefulWidget {
  const MainSawab({super.key});

  @override
  State<MainSawab> createState() => _MainSawabState();
}

class _MainSawabState extends State<MainSawab> {
  static const _mainMenuColor = Color.fromARGB(255, 255, 251, 245);
  bool test2 = false; // Отображать или Скрыть меню модификации сауабов
  // final List Sawabs = SawabData.sawabs;
// ------------------------------------------------------SQL--------------------------------
  List<Map<String, dynamic>> _journals = []; // All journals
  List<double> siarv = [0]; // Sawab item arr values
  List<String> siart = ['']; // Sawab item arr values

  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems(); //               load data ON data
    setState(() {
      _journals = data; //                               save data ON _journals
      siarv = [];
      siart = [];
      String str1 = '';
      List<String> result1 = [];

      for (int i = 0; i < _journals.length; i++) {
        siarv.add(double.tryParse(_journals[i]['description']) ?? 0); // okValue OR def0
        //siart.add(_journals[i]['title'] ?? (i + 1).toString()); // ok Title OR def i number
        //siart.add('y$i'); // ok Title OR def i number
        str1 = ''; // clear
        result1 = []; // clear
        str1 = _journals[i]['title'];
        str1 = str1.trim();
        if (str1 == "") {
          siart.add((i + 1).toString()); // hand over т.к. пусто Передаем i
          continue;
        }
        result1 = str1.split(" ");
        str1 = '';
        for (int j = 0; j < result1.length; j++) {
          //str1 = result1[j].substring(0, 1);
          if (j > 2) {
            break; // Не долпускать больше 3х символоы в Названии столбца
          }
          str1 = str1 + result1[j].substring(0, 1);
        }
        // print('str1 == $str1');
        siart.add(str1); // hand over Передаем текста Bar в 2 символа
      }
      // String text = "  Из данного текста получим список слов  ";
      // // разбиваем текст, используя пробел
      // text = text.trim();
      // List<String> list = text.split(" ");

      // print(list.length); // 6, полученный массив содержит 6 элементов
      // print(list[0].substring(0, 1)); // "Из"
      // print(list[1].substring(0, 1)); // "данного"

      //SIArrUpdate(context);
      //    print('>>>>>>>>>>>>>>>>>>> _refreshJournals: _itemSize=' + _itemSize.toString());
      if (_journals.length == 0) _default_SawabItems(); // TEMP чтобы не было Пусто async _addItem();

      //await _addItem();
      // _deleteItem(_journals[index]['id']),
      // await _updateItem(id);
      // _deleteItem(_journals[_journals.length - 1]['id']);
    });
  }

  @override
  void initState() {
    // print('begin initState ...................');
    super.initState();
    _refreshJournals(); //                Loading the diary when THE APP STARTS
    // print('end initState ...................');
    //  _addItem();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

// isDelete = false: ADD-UPDATE form
  void _showForm(int? id) async {
    const TextStyle _style = TextStyle(
        //height: 1.5,
        fontSize: 23, // 19
        fontFamily: 'Comfortaa',
        color: Colors.black // _coloredValue ? Colors.teal[500] : Colors.black,
        );

    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal = _journals.firstWhere((element) => element['id'] == id); // find by id
      //                                                        then READ title
      _titleController.text = existingJournal['title'];
      //                                                  then READ description
      _descriptionController.text = existingJournal['description'];
    } else {
      _titleController.text = '';
      //                                                  then READ description
      _descriptionController.text = '';
    }
    // final keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    // final keyboardSize = EdgeInsets.fromViewPadding(WidgetsBinding.instance.window.viewInsets, WidgetsBinding.instance.window.devicePixelRatio);
    //  ADD-UPDATE MENU -  show Modal Bottom Shit - LIST Items on Main menu
    // =====================================================================================
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              color: _mainMenuColor, // fon
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                //
                bottom: getKeyboardHeight(context) + 11,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: 'Введите текст'),
                    controller: _titleController,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    style: _style,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: 'Введите значение'),
                    controller: _descriptionController,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    style: _style,
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new journal
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      _titleController.text = '';
                      _descriptionController.text = '';

                      // Close the bottom sheet & RETURN previous Menu
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: id == null ? Colors.teal : Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 15),
                      textStyle: _style,
                    ),
                    child: Text(
                      id == null ? 'Добавить' : 'Обновить',
                      //  style: _style,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                ],
              ),
            ));
  }

// isDelete = false: ADD-UPDATE form \ true: DELETE form
  void _showFormDelete(BuildContext context, int _val) async {
    const TextStyle _style = TextStyle(
        //height: 1.5,
        fontSize: 19, // 19
        fontFamily: 'Comfortaa',
        color: Colors.black // _coloredValue ? Colors.teal[500] : Colors.black,
        );

    //const Color _fonColor = Colors.pink.shade100; // ниже сконвертирвал в RBGO

    //  DELETE MENU -  show Modal Bottom Shit - LIST Items on Main menu
    // =====================================================================================
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              color: _mainMenuColor,
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: 11, // здесь нет клавиатуры поэтому нет нужды использовать getKeyboardHeight(context)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    'Удалить выбранные $_val ? ',
                    style: _style,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      SIDelete(context);

                      // Close the bottom sheet & RETURN previous Menu
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade300,
                      padding: EdgeInsets.symmetric(horizontal: 27, vertical: 15),
                      textStyle: _style,
                    ),
                    child: Text('Удалить'),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                ],
              ),
            ));
  }

//  onPressed: () => _showForm(null), // ADD NEW ITEM

  // _showForm(null), // CREATE-ADD item
  // Insert a new journal to the database                             CREATE item
  Future<void> _addItem() async {
    // await SQLHelper.createItem(
    // await SQLHelper.createItem(
    //     _titleController.text, _descriptionController.text);
    await SQLHelper.createItem(_titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  // Future<void> _editItem() async {
  //   // await SQLHelper.createItem(
  //   // await SQLHelper.createItem(
  //   //     _titleController.text, _descriptionController.text);
  //   await SQLHelper.createItem(_titleController.text, _descriptionController.text);
  //   _refreshJournals();
  // }

  Future<void> _default_SawabItems() async {
    //  await SQLHelper.createItem(
    //     _titleController.text, _descriptionController.text);
    await SQLHelper.createItem('Добрые дела', '0');
    await SQLHelper.createItem('Пятничная проповедь', '0');
    await SQLHelper.createItem('Тахаджут', '0');
    await SQLHelper.createItem('Нафль Намаз', '0');
    await SQLHelper.createItem('Нафль Ораза', '0');
    await SQLHelper.createItem('Тилават', '0');
    await SQLHelper.createItem('Бакара первые 17 аятов', '0');
    _refreshJournals();
  }

  // _showForm(_journals[index]['id']), // EDIT item
  // Update an existing journal                                     UPDATE item

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(id, _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  Future<void> _updateItemPlusMinus(int _id, String _text, _val) async {
    await SQLHelper.updateItem(_id, _text, _val);
    _refreshJournals();
  }

  // _deleteItem(_journals[index]['id']), // DELETE item
  // Delete an item                                                 DELETE item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text('Successfully deleted a journal!'),
    // ));
    //_refreshJournals();
  }

  // Get Keyboard SizeHeight когда клавиатура отражена
  double getKeyboardHeight(BuildContext context) {
    final _keyboardSize = EdgeInsets.fromViewPadding(
        WidgetsBinding.instance.window.viewInsets, WidgetsBinding.instance.window.devicePixelRatio);
    return _keyboardSize.bottom;
  }

// --------------------------------------------SQL------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Simp(), //change builder to create
      child: Consumer<Simp>(
        builder: (context, provider, child) => Scaffold(
          // child: Scaffold(
          backgroundColor: _mainMenuColor,
          body: Column(
            children: [
              Expanded(
                flex: 8, // 20%
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 221, // size Bar external border Y
                      child: SawabBar(arrv: siarv, arrt: siart),
                    ),
                    const SizedBox(height: 21),
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: ReorderableListView.builder(
                  // key: UniqueKey(),
                  //itemCount: Sawabs.length, // how many items
                  itemCount: _journals.length,
                  itemBuilder: (context, int index) {
                    // => Builder(
                    //                         builder: (BuildContext newContext) {
                    return SawabItems(
                      key: Key('$index'), // ValueKey(index), // Key('$index'),
                      myIndex: index,
                      // myText: Sawabs[index].SawabName,
                      //  myVal: Sawabs[index].SawabSum,
                      myText: _journals[index]['title'],
                      myVal: _journals[index]['description'],
                      showSelect: context.read<Simp>().setSiv(_journals.length, index),
                      //cirMenu: test2, // _sms
                      // onFlatButtonPressed: () {},
                    );
                  },

                  ////////////////
                  onReorder: (int oldIndex, int newIndex) {},
                ),
              ),
              Visibility(
                visible: context.watch<Simp>().sms, // _SawabModMenuShow
                child: Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 5, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LikeButton(
                              // DELETE
                              //------------- LikeButton
                              // padding: const EdgeInsets.only(right: 11),
                              // animationDuration: const Duration(milliseconds: 250),
                              likeBuilder: (bool isLiked) {
                                //return const Icon(Icons.delete_outlined, color: Colors.deepOrange, size: 35);
                                return const Icon(Icons.delete_outlined,
                                    color: Color.fromARGB(201, 233, 30, 98), size: 35);
                              },
                              // isLiked: false,
                              // size: 45,
                              onTap: (isLiked) async {
                                // DELETE CLICK
                                if (_journals.length > 0) {
                                  if (context.read<Simp>().osiv_calc()) {
                                    //   print(' osiv_calc == true ....');
                                    _showFormDelete(context, context.read<Simp>().osiv.length);
                                  }
                                }
                                return Future.value(null);
                              },
                            ),
                            // const SizedBox(width: 7),
                            LikeButton(
                              // MINUS
                              padding: const EdgeInsets.only(bottom: 3),
                              animationDuration: const Duration(milliseconds: 250),
                              //postFrameCallback: (state) => print('------- tap!'),
                              likeBuilder: (bool isLiked) {
                                return const Icon(Icons.exposure_minus_1, color: Colors.pinkAccent, size: 41);
                              },
                              isLiked: null,
                              // size: 45,
                              onTap: (isLiked) async {
                                // MINUS CLICK
                                SIPlusMinus(context, -1);
                                return Future.value(null);
                              },
                            ),
                            const SizedBox(width: 11),
                            LikeButton(
                              // UPDATE
                              //------------- LikeButton
                              padding: const EdgeInsets.only(bottom: 3),
                              // animationDuration: const Duration(milliseconds: 250),

                              likeBuilder: (bool isLiked) {
                                // motion_photos_auto_outlined
                                //return const Icon(Icons.miscellaneous_services_rounded, color: Colors.green, size: 45);
                                return Icon(
                                  Icons.build_circle_outlined,
                                  color: context.watch<Simp>().sime ? Colors.blueAccent : Colors.black12,
                                  size: 41,
                                );
                              },
                              // isLiked: false,
                              // size: 45,
                              onTap: (isLiked) async {
                                // UPDATE CLICK
                                SIEditor(context);
                                return Future.value(null);
                              },
                            ),

                            const SizedBox(width: 11),
                            LikeButton(
                              // PLUS
                              padding: const EdgeInsets.only(bottom: 3), //left: 11),
                              animationDuration: const Duration(milliseconds: 250),
                              likeBuilder: (bool isLiked) {
                                return const Icon(Icons.exposure_plus_1, color: Colors.greenAccent, size: 41);
                              },
                              isLiked: null,
                              // size: 45,
                              onTap: (isLiked) async {
                                // PLUS CLICK
                                SIPlusMinus(context, 1);
                                return Future.value(null);
                              },
                            ),
                            const SizedBox(width: 11),
                            LikeButton(
                              // ADD
                              padding: const EdgeInsets.only(top: 3), //left: 11),
                              // animationDuration: const Duration(milliseconds: 250),
                              likeBuilder: (bool isLiked) {
                                return const Icon(Icons.addchart, color: Colors.green, size: 33);
                              },
                              // isLiked: false,
                              // size: 45,
                              onTap: (isLiked) async {
                                // ADD CLICK
                                //await _addItem();
                                _showForm(null);
                                return Future.value(null);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !context.watch<Simp>().sms, // _SawabModMenuShow
                child: Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Container(
                        width: 44,
                        height: 44,
                        child: LikeButton(
                          // ADD
                          padding: EdgeInsets.only(left: 11),
                          animationDuration: const Duration(milliseconds: 250),
                          likeBuilder: (bool isLiked) {
                            return const Icon(Icons.addchart, color: Colors.green, size: 35);
                          },
                          isLiked: false,
                          // size: 45,
                          onTap: (isLiked) async {
                            // ADD CLICK
                            //await _addItem();
                            _showForm(null);
                            return Future.value(null);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Sawab Item - Update Variable +1\-1
  void SIPlusMinus(BuildContext context, int _newVal) {
    if (context.read<Simp>().osiv_calc()) {
      // print(' osiv_calc == true ....');
      for (int i = 0; i < context.read<Simp>().osiv.length; i++) {
        // print('osiv[i] == ' + context.read<Simp>().osiv[i].toString());

        String _str = '0' + _journals[context.read<Simp>().osiv[i]]['description']; // 0+ защита от бага DT!
        //  print(_str);
        int _val = int.parse(_str.replaceAll(RegExp(r'[^0-9]'), ''));
        // print('_val bef == ' + _val.toString());

        _val = _val + _newVal; // PLUS !!
        // print('_val aft == ' + _val.toString());
        if (_val < 0) {
          _val = 0;
        }
        if (_val >= 0)
          _updateItemPlusMinus(
            _journals[context.read<Simp>().osiv[i]]['id'],
            _journals[context.read<Simp>().osiv[i]]['title'],
            _val.toString(),
          );
        else
          print(' func PlusMinus _val < 0 !!!');
      }
    }
  }

// Sawab Item Editor - Update item
  void SIEditor(BuildContext context) {
    if (context.read<Simp>().osiv_calc() && context.read<Simp>().osiv.length == 1) {
      // int _val = _journals[context.read<Simp>().osiv[0]]['id'];
      _showForm(_journals[context.read<Simp>().osiv[0]]['id']);
    }
  }

  // Sawab Item - Delete selected items
  void SIDelete(BuildContext context) {
    for (int i = 0; i < context.read<Simp>().osiv.length; i++) {
      _deleteItem(_journals[context.read<Simp>().osiv[i]]['id']);
      _refreshJournals();
      context.read<Simp>().setSivZero(); // Set select 0 elements
      context.read<Simp>().sms = false;
      //context.read<Simp>().iarr = _journals;
    }
  }
}

// после добавление - НАДО сделать чтобы только этот 1 элемент Выделился
// надо добавить пермещение элементов списка items через LongClick
