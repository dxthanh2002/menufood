import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_menu_flutter/features/home/step2_confirm/confirm_ingredients_screen.dart';

void main() {
  testWidgets('confirm ingredients screen renders ingredient controls', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ConfirmIngredientsScreen(imagePath: 'test/fake-image.jpg'),
      ),
    );

    expect(find.text('Confirm Ingredients'), findsOneWidget);
    expect(find.text('SELECTED PHOTO'), findsNothing);
    expect(find.text('DETECTED INGREDIENTS'), findsOneWidget);
  });
}
