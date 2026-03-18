import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

import '../../../navigation/routes.dart';
import '../../../theme/colors.dart';
import 'scanner_viewmodel.dart';
import 'scanner_frame_overlay.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScannerViewModel()..initCamera(),
      child: const _ScannerContent(),
    );
  }
}

class _ScannerContent extends StatefulWidget {
  const _ScannerContent();

  @override
  State<_ScannerContent> createState() => _ScannerContentState();
}

class _ScannerContentState extends State<_ScannerContent>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final vm = context.read<ScannerViewModel>();
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      vm.controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      vm.initCamera();
    }
  }

  Future<void> _onCapturePressed() async {
    final vm = context.read<ScannerViewModel>();
    await vm.captureImage();
    if (!mounted) return;

    if (vm.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(vm.errorMessage!)),
      );
      vm.clearError();
      return;
    }

    Navigator.pushNamed(context, Routes.confirmIngredients);
  }

  void _onUploadPressed() {
    // TODO: implement image picker
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScannerViewModel>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview — fullscreen
          if (vm.isInitialized && vm.controller != null)
            Positioned.fill(child: CameraPreview(vm.controller!))
          else
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),

          // Scanner frame overlay
          const Positioned.fill(child: ScannerFrameOverlay()),

          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: _buildTopBar(vm),
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: _buildBottomControls(vm),
            ),
          ),

          // Processing overlay
          if (vm.isProcessing)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(color: AppColors.primary),
                      const SizedBox(height: 16),
                      Text(
                        'Detecting...',
                        style: GoogleFonts.inter(
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
      ),
    );
  }

  Widget _buildTopBar(ScannerViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Close button
          _circleButton(
            icon: Icons.close,
            onTap: () => Navigator.pop(context),
          ),
          const Spacer(),
          // Live Detection badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'LIVE DETECTION',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Flash button
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
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  IconData _flashIcon(FlashMode m) => switch (m) {
        FlashMode.off => Icons.flash_off,
        FlashMode.auto => Icons.flash_auto,
        FlashMode.always => Icons.flash_on,
        FlashMode.torch => Icons.highlight,
      };

  Widget _buildBottomControls(ScannerViewModel vm) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withValues(alpha: 0.7),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Upload button
              _buildUploadButton(),
              const SizedBox(width: 24),
              // Capture button (center, larger)
              _buildCaptureButton(vm),
              const SizedBox(width: 24),
              // Spacer to balance layout
              const SizedBox(width: 56),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton() {
    return GestureDetector(
      onTap: _onUploadPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
                width: 1.5,
              ),
            ),
            child: const Icon(Icons.photo_library_outlined,
                color: Colors.white, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            'UPLOAD',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptureButton(ScannerViewModel vm) {
    return GestureDetector(
      onTap: vm.isProcessing ? null : _onCapturePressed,
      child: Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 4),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
