import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FacialVerify extends StatefulWidget {
  const FacialVerify({Key? key, required this.cameras}) : super(key: key);
  final CameraDescription cameras;

  @override
  State<FacialVerify> createState() => _FacialVerifyState();
}

class _FacialVerifyState extends State<FacialVerify> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<void> initCamera(CameraDescription camera) async {
    _controller = CameraController(
      camera,
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  initState() {
    super.initState();
    initCamera(widget.cameras);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: FloatingActionButton(
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  if (!mounted) return;
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imagePath: image.path,
                      ),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: const Icon(Icons.camera_alt),
            )),
      ],
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Display the Picture'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.file(File(imagePath)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Retake',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ));
  }
}
