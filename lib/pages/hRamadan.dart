import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// Reliable Hadis - Достоверные Хадисы
// Accepted Prayer - Принятый Намаз
class HRamadan extends StatefulWidget {
  const HRamadan({super.key});

  @override
  State<HRamadan> createState() => _HRamadanState();
}

class _HRamadanState extends State<HRamadan> {
  Offset dragGesturePositon = Offset.zero;
  bool prepMag = false;
  bool showMag = false;
  // bool virubit = false;
  double x = 0.0;
  double y = 0.0;

  @override
  dispose() {
    SfPdfViewer.asset('lib/assets/pdf/Ramadan.pdf').controller?.dispose();
    super.dispose();
  }

  void _incrementDown(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      // print('        11          ');
      prepMag = true; // Show magnifier Показать
      // virubit = false;
      // print('        prepMag = true          ');
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          // print('        1 second FINISH !          ');
          if (prepMag) {
            // print('           ................    SHOW MAG  = true !          ');
            showMag = true;
            x = details.position.dx;
            y = details.position.dy;
          }
          //   showLoop = true; // Show magnifier Показать
        });
      });
    });
  }

  void _incrementUp(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      // virubit = true;
      prepMag = false; // Show magnifier Показать Лупу
      showMag = false; // Show magnifier Показать

      // print('        22222  prepMag = false          ');
    });
  }

  void _updateLocation(PointerEvent details) {
    if (showMag) {
      setState(() {
        x = details.position.dx;
        y = details.position.dy;
        // print('        33333333333333          ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Listener(
          onPointerDown: _incrementDown,
          onPointerMove: _updateLocation,
          onPointerUp: _incrementUp,
          child: GestureDetector(
            child: Center(
              child: SfPdfViewer.asset(
                'lib/assets/pdf/Ramadan.pdf',
                // enableDoubleTapZooming: true,
              ),
              // child: SfPdfViewer.network(
              //   "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
              //   onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              //     showErrorDialog(context, details.error, details.description);
              //   },
              // ),
            ),
          ),
        ),
        if (showMag)
          Positioned(
            left: x - 157,
            top: y - 221,
            child: const RawMagnifier(
              decoration: MagnifierDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              size: Size(313, 245),
              magnificationScale: 2,
            ),
          )
      ],
    );
  }
}
