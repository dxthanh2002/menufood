import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class ScannerViewModel extends ChangeNotifier {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isProcessing = false;
  FlashMode _flashMode = FlashMode.off;
  List<CameraDescription> _cameras = [];
  int _currentCameraIndex = 0;
  String? _errorMessage;
  String? _imagePath;
  final ImagePicker _imagePicker = ImagePicker();

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isProcessing => _isProcessing;
  FlashMode get flashMode => _flashMode;
  String? get errorMessage => _errorMessage;
  String? get imagePath => _imagePath;

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

    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

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

  Future<void> captureImage() async {
    if (_controller == null || !_isInitialized || _isProcessing) return;

    _isProcessing = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final XFile image = await _controller!.takePicture();
      _imagePath = image.path;
    } catch (e) {
      debugPrint('Capture error: $e');
      _errorMessage = 'Could not capture image. Please try again.';
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }

  Future<bool> pickImageFromGallery() async {
    _errorMessage = null;

    _isProcessing = true;
    notifyListeners();

    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (image != null) {
        _imagePath = image.path;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Gallery picker error: $e');
      _errorMessage = 'Could not open photo library. Please try again.';
      notifyListeners();
      return false;
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
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
