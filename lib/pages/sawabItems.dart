import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:Sawab/core.dart';

class SawabItems extends StatefulWidget {
  //final key; // DT for DND move item (long select)
  // final VoidCallback onFlatButtonPressed;
  final num myIndex;
  final String myText;
  final String myVal;
  //bool cirMenu;
  final int showSelect;
  static const maxPersent = 31; // Max Value this.myVal,
  const SawabItems({
    // required this.key,
    super.key,
    //required this.onFlatButtonPressed,
    required this.myIndex,
    required this.myText,
    required this.myVal,
    //required this.cirMenu,
    required this.showSelect,
  });

  @override
  State<SawabItems> createState() => _SawabItemsState();
}

class _SawabItemsState extends State<SawabItems> {
  @override
  void initState() {
    super.initState();
    // print('++++ context.read<Simp>().siv.length =' + context.read<Simp>().siv.length.toString());
    // print('++++ context.read<Simp>().siv[0] =' + context.read<Simp>().siv[0].toString());
    // print('++++ context.read<Simp>().siv[1] =' + context.read<Simp>().siv[1].toString());
    // print('++++ context.read<Simp>().siv[2] =' + context.read<Simp>().siv[2].toString());
    //  _addItem();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        //padding: const EdgeInsets.all(11.0),
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          // color: widget.showSelect == 0 ? Colors.deepPurple[100] : Colors.amber[300], // /*widget.showSelect*/ 0
          color: widget.showSelect == 0 ? Colors.green[100] : Colors.amber[200], // /*widget.showSelect*/ 0
        ),

        child: InkWell(
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.showSelect == 0
                        ? SawabItemText(widget.myText, false, true) // LEFT text NOT selected
                        : SawabItemText(widget.myText, true, true), // LEFT text IS selected
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.showSelect == 0
                            ? SawabItemText(widget.myVal.toString(), false, false) // RIGHT text NOT selected
                            : SawabItemText(widget.myVal.toString(), true, false), // RIGHT text IS selected
                      ],
                    ),
                  )),
            ],
          ),
          onTap: () {
            context.read<Simp>().calc(widget.myIndex);
            // print('------------------- TAP !!');
            // setState(() {
            //   widget.onFlatButtonPressed();
            // });
          },
        ),
      ),
    );
  }
}

class SawabItemText extends StatelessWidget {
  final String _itemtext; // item text
  final bool _bold; // text bold def false
  // final bool _coloredValue; // enable Alternative color text
  final bool _enableColon; // enable :
  const SawabItemText(this._itemtext, this._bold, this._enableColon, {super.key});

  @override
  Widget build(BuildContext context) {
    // String a = _enableColon == true ? '': '';
    ;
    return Text(_itemtext.toString() + (_enableColon ? ' : ' : ''),
        style: TextStyle(
          height: 1.5,
          fontSize: _bold ? 21 : 19, // 19
          fontFamily: 'Comfortaa',
          color: _enableColon ? Colors.black : Colors.teal[500],
          //  fontWeight: _bold ? FontWeight.w700 : FontWeight.w500,
          //backgroundColor: Colors.white,
        ));
  }
}
