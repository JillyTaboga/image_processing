import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class _CameraWidget extends StatefulWidget {
  const _CameraWidget();

  @override
  State<_CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<_CameraWidget> {
  bool isLoading = true;
  bool error = false;
  List<CameraDescription> cameras = [];
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  initialize() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) throw Exception('No cameras found');
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      await controller?.initialize();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      log(e.toString());
      setState(() {
        error = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 400,
          maxWidth: 400,
        ),
        child: SizedBox.expand(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : error
                  ? const Center(
                      child: Text('Não foi possível se conectar a camera'),
                    )
                  : CameraPreview(
                      controller!,
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            bottom: 15,
                            child: FloatingActionButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.camera,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
