import 'package:flutter/material.dart';
import '../bottom_navigation/root-tab-app-bar.dart';
import '../../theme/colors.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      appBar: RootTabAppBar(title: 'History'),
      body: Center(
        child: Text(
          'History Screen',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
