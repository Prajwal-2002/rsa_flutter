import 'package:camera/camera.dart';
import 'package:unisys_qr_code/facial_verify.dart';
import 'package:unisys_qr_code/voice_verify.dart';
import 'package:flutter/material.dart';

class QrValue extends StatelessWidget {
  String? qrInfo;
  QrValue({Key? key, required this.qrInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('The value of the QR/Bar Code'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '$qrInfo',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                elevation: MaterialStateProperty.all<double>(15.0),
                shadowColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: const Text('Go back to scan a QR/Bar Code'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                elevation: MaterialStateProperty.all<double>(15.0),
                shadowColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () async {
                await availableCameras().then((cameras) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FacialVerify(
                        cameras: cameras[1],
                      ),
                    ),
                  );
                });
              },
              child: const Text('Continue to facial verification'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                elevation: MaterialStateProperty.all<double>(15.0),
                shadowColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecorderExample(),
                  ),
                );
              },
              child: const Text('Continue to voice verification'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                elevation: MaterialStateProperty.all<double>(15.0),
                shadowColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecorderExample(),
                  ),
                );
              },
              child: const Text('Continue to cryptographic verification'),
            ),
          ],
        ),
      ),
    );
  }
}
