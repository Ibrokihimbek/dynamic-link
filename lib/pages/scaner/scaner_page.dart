import 'dart:io';

import 'package:dynamic_link_example/servises/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanerPage extends StatefulWidget {
  const ScanerPage({super.key});

  @override
  State<ScanerPage> createState() => _ScanerPageState();
}

class _ScanerPageState extends State<ScanerPage> {
  late MobileScannerController controller = MobileScannerController();
  late RRect scanWindow;
  late Rect rect;
  late Rect windowRect;
  late Size size;

  Barcode? barcode;
  BarcodeCapture? capture;

  Future<void> onDetect(BarcodeCapture barcode) async {
    capture = barcode;
    setState(() => this.barcode = barcode.barcodes.first);
  }

  MobileScannerArguments? arguments;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: 250,
      height: 250,
    );
    scanWindow = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(12),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            fit: StackFit.expand,
            children: [
              MobileScanner(
                fit: BoxFit.cover,
                scanWindow: rect,
                controller: controller,
                onScannerStarted: (arguments) {
                  setState(() {
                    this.arguments = arguments;
                  });
                },
                onDetect: (capture) async {
                  await onDetect(capture);
                  if (!mounted) return;
                  Navigator.pop(context);
                },
              ),
              if (barcode != null &&
                  barcode?.corners != null &&
                  arguments != null)
                CustomPaint(
                  painter: BarcodeOverlay(
                    barcode: barcode!,
                    arguments: arguments!,
                    boxFit: BoxFit.contain,
                    capture: capture!,
                  ),
                ),
              Positioned.fill(
                top: (size.height / 2) + 136 - 600,
                child: CustomPaint(
                  painter: ScannerOverlay(scanWindow),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: (size.height / 3.5),
                child: const Text(
                  "Отсканируйте QR-код на Q.watt",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                bottom: 24,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Не можете отсканировать QR код?'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.light_mode_rounded),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
