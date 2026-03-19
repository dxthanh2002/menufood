import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(vm.errorMessage!)));
      vm.clearError();
      return;
    }

    Navigator.pushNamed(context, Routes.confirmIngredients);
  }

  Future<void> _onUploadPressed() async {
    final vm = context.read<ScannerViewModel>();
    final isImageSelected = await vm.pickImageFromGallery();
    if (!mounted) return;

    if (vm.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(vm.errorMessage!)));
      vm.clearError();
      return;
    }

    if (!isImageSelected) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image selected from library.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScannerViewModel>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
          // Camera preview â€” fullscreen with BoxFit.cover logic
          if (vm.isInitialized && vm.controller != null)
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ClipRect(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        height:
                            constraints.maxWidth *
                            vm.controller!.value.aspectRatio,
                        child: CameraPreview(vm.controller!),
                      ),
                    ),
                  );
                },
              ),
            )
          else
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),

          // Scanner frame overlay
          const Positioned.fill(child: ScannerFrameOverlay()),

          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(bottom: false, child: _buildTopBar(vm)),
          ),

          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomControls(vm),
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
      ),
    );
  }

  Widget _buildTopBar(ScannerViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Close button
          _circleButton(icon: Icons.close, onTap: () => Navigator.pop(context)),
          const Spacer(),
          // Live Detection badge
          _buildGlassSurface(
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
      child: _buildGlassSurface(
        width: 42,
        height: 42,
        borderRadius: BorderRadius.circular(21),
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
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        0,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: _buildGlassSurface(
        borderRadius: BorderRadius.circular(44),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: _buildUploadButton(),
            ),
            _buildCaptureButton(vm),
            const Expanded(
              child: SizedBox(), // Balance for the upload button on the left
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassSurface({
    required Widget child,
    required BorderRadius borderRadius,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double? width,
    double? height,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white.withValues(alpha: 0.15),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: child,
      ),
    );
  }


  Widget _buildUploadButton() {
    return GestureDetector(
      onTap: _onUploadPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // This spacer centers the icon circle relative to the capture button
          // by offsetting the text height and spacing below.
          const SizedBox(height: 20),
          _buildGlassSurface(
            width: 48,
            height: 48,
            borderRadius: BorderRadius.circular(24),
            child: const Icon(
              Icons.photo_library_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'UPLOAD',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
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
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: 3,
          ),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          child: const Icon(
            Icons.camera_alt_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}

