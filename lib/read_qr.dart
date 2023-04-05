import 'package:unisys_qr_code/show_qr_value.dart';
import 'package:flutter/material.dart';
import 'package:unisys_qr_code/flutter_qr_bar_scanner_camera.dart';

class ReadQr extends StatefulWidget {
  ReadQr({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _ReadQrState createState() => _ReadQrState();
}

class _ReadQrState extends State<ReadQr> {
  String? qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      qrInfo = code;
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
          centerTitle: true,
          leading: IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: Icon(Icons.arrow_back)),
        ),
        body: _camState
            ? Center(
                child: SizedBox(
                  height: 1000,
                  width: 500,
                  child: QRBarScannerCamera(
                    onError: (context, error) => Text(
                      error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                    qrCodeCallback: (code) {
                      _qrCallback(code);
                    },
                  ),
                ),
              )
            : QrValue(qrInfo: qrInfo));
  }
}
