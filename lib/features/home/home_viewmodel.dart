import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import '../../navigation/routes.dart';

class HomeViewModel extends ChangeNotifier {
  final ImagePicker _imagePicker = ImagePicker();
  bool _isPicking = false;
  bool get isPicking => _isPicking;

  Future<void> pickImageToConfirm(BuildContext context) async {
    if (_isPicking) return;
    _isPicking = true;
    notifyListeners();

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (image != null && context.mounted) {
        Navigator.pushNamed(
          context,
          Routes.confirmIngredients,
          arguments: image.path,
        );
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    } finally {
      _isPicking = false;
      notifyListeners();
    }
  }
}
