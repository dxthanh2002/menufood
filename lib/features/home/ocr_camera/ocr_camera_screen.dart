import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

import 'ocr_camera_viewmodel.dart';
import 'ocr_camera_selection_overlay.dart';

class OCRCameraScreen extends StatelessWidget {
  const OCRCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OCRCameraViewModel()..initCamera(),
      child: const _OCRCameraContent(),
    );
  }
}

class _OCRCameraContent extends StatefulWidget {
  const _OCRCameraContent();

  @override
  State<_OCRCameraContent> createState() => _OCRCameraContentState();
}

class _OCRCameraContentState extends State<_OCRCameraContent>
    with WidgetsBindingObserver {
  final ValueNotifier<Rect> _selectionNotifier = ValueNotifier(Rect.zero);
  Size _previewSize = Size.zero;
  bool _selectionInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _selectionNotifier.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final vm = context.read<OCRCameraViewModel>();
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      vm.controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      vm.initCamera();
    }
  }

  void _initDefaultSelection(Size size) {
    if (_selectionInitialized && _previewSize == size) return;
    _previewSize = size;
    _selectionInitialized = true;
    _selectionNotifier.value = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.85,
      height: size.height * 0.55,
    );
  }

  Future<void> _onInsertPressed() async {
    final vm = context.read<OCRCameraViewModel>();
    final text = await vm.captureAndRecognize(_selectionNotifier.value, _previewSize);
    if (!mounted) return;

    if (text == null || text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(vm.errorMessage ?? 'No text found. Try again.')),
      );
      vm.clearError();
      return;
    }

    Navigator.pop(context, text);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OCRCameraViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Column(
        children: [
          SafeArea(bottom: false, child: _buildTopBar(vm)),
          Expanded(child: _buildCameraWithSelection(vm)),
          _buildBottomSection(vm),
        ],
      ),
    );
  }

  // ── Top Bar ──────────────────────────────────────────────────────────

  Widget _buildTopBar(OCRCameraViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _circleButton(
            icon: Icons.chevron_left,
            onTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: Center(
              child: Text(
                'IMAGE SELECTION',
                style: GoogleFonts.manrope(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          _circleButton(
            icon: _flashIcon(vm.flashMode),
            onTap: vm.toggleFlashMode,
          ),
        ],
      ),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 22),
      ),
    );
  }

  IconData _flashIcon(FlashMode m) => switch (m) {
        FlashMode.off => Icons.flash_off,
        FlashMode.auto => Icons.flash_auto,
        FlashMode.always => Icons.flash_on,
        FlashMode.torch => Icons.highlight,
      };

  // ── Camera + Selection Overlay ───────────────────────────────────────

  Widget _buildCameraWithSelection(OCRCameraViewModel vm) {
    if (!vm.isInitialized || vm.controller == null) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            _initDefaultSelection(constraints.biggest);
            return Stack(
              children: [
                Positioned.fill(child: CameraPreview(vm.controller!)),
                Positioned.fill(
                  child: OCRSelectionOverlay(selectionNotifier: _selectionNotifier),
                ),
                if (vm.isProcessing)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.5),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(color: Colors.white),
                            const SizedBox(height: 16),
                            Text(
                              'Recognizing text...',
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ── Bottom Section ───────────────────────────────────────────────────

  Widget _buildBottomSection(OCRCameraViewModel vm) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select the area to extract text',
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Drag the corners of the box to highlight the\nspecific text you want to import.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: vm.isProcessing ? null : _onInsertPressed,
                icon: vm.isProcessing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.auto_awesome, size: 18),
                label: Text(
                  vm.isProcessing ? 'Processing...' : 'Insert into Chat',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFF2563EB).withValues(alpha: 0.5),
                  disabledForegroundColor: Colors.white.withValues(alpha: 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
