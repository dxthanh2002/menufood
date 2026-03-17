import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';

class OCRCameraViewModel extends ChangeNotifier {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isProcessing = false;
  FlashMode _flashMode = FlashMode.off;
  List<CameraDescription> _cameras = [];
  int _currentCameraIndex = 0;
  String? _errorMessage;

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isProcessing => _isProcessing;
  FlashMode get flashMode => _flashMode;
  String? get errorMessage => _errorMessage;

  Future<void> initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;
      await _startCamera(_cameras[_currentCameraIndex]);
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  Future<void> _startCamera(CameraDescription camera) async {
    _isInitialized = false;
    notifyListeners();

    if (_controller != null) {
      await _controller!.dispose();
    }

    _controller = CameraController(camera, ResolutionPreset.high, enableAudio: false);

    try {
      await _controller!.initialize();
      await _controller!.setFlashMode(_flashMode);
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error starting camera: $e');
    }
  }

  Future<void> toggleFlashMode() async {
    if (_controller == null || !_isInitialized) return;
    switch (_flashMode) {
      case FlashMode.off:
        _flashMode = FlashMode.auto;
      case FlashMode.auto:
        _flashMode = FlashMode.always;
      case FlashMode.always:
        _flashMode = FlashMode.off;
      default:
        _flashMode = FlashMode.off;
    }
    try {
      await _controller!.setFlashMode(_flashMode);
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting flash: $e');
    }
  }

  Future<void> switchCamera() async {
    if (_cameras.length < 2) return;
    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length;
    await _startCamera(_cameras[_currentCameraIndex]);
  }

  /// Capture, crop to selection rect, run OCR, return text.
  Future<String?> captureAndRecognize(Rect selectionRect, Size previewSize) async {
    if (_controller == null || !_isInitialized || _isProcessing) return null;

    _isProcessing = true;
    _errorMessage = null;
    notifyListeners();

    TextRecognizer? textRecognizer;
    File? imageFile;
    File? croppedFile;

    try {
      final xFile = await _controller!.takePicture();
      imageFile = File(xFile.path);

      croppedFile = await _cropImage(imageFile, selectionRect, previewSize);

      final inputImage = InputImage.fromFilePath(croppedFile.path);
      textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final recognized = await textRecognizer.processImage(inputImage);

      return recognized.text.trim();
    } catch (e) {
      debugPrint('OCR error: $e');
      _errorMessage = 'Could not recognize text. Please try again.';
      notifyListeners();
      return null;
    } finally {
      await textRecognizer?.close();
      imageFile?.delete().ignore();
      croppedFile?.delete().ignore();
      _isProcessing = false;
      notifyListeners();
    }
  }

  Future<File> _cropImage(File imageFile, Rect selection, Size displaySize) async {
    final bytes = await imageFile.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final scaleX = image.width / displaySize.width;
    final scaleY = image.height / displaySize.height;

    final cropRect = Rect.fromLTRB(
      (selection.left * scaleX).clamp(0.0, image.width.toDouble()),
      (selection.top * scaleY).clamp(0.0, image.height.toDouble()),
      (selection.right * scaleX).clamp(0.0, image.width.toDouble()),
      (selection.bottom * scaleY).clamp(0.0, image.height.toDouble()),
    );

    if (cropRect.width < 1 || cropRect.height < 1) {
      throw Exception('Selection area too small.');
    }

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawImageRect(
      image,
      cropRect,
      Rect.fromLTWH(0, 0, cropRect.width, cropRect.height),
      Paint(),
    );

    final picture = recorder.endRecording();
    final cropped = await picture.toImage(cropRect.width.toInt(), cropRect.height.toInt());
    final byteData = await cropped.toByteData(format: ui.ImageByteFormat.png);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/ocr_crop_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(byteData!.buffer.asUint8List());

    image.dispose();
    cropped.dispose();

    return file;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
