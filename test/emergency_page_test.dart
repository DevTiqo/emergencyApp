import 'package:emergencyApp/emergency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EmergencyPage renders correctly', (WidgetTester tester) async {
    // Create a mock AnimationController.
    final animationController = AnimationController(
      vsync: const TestVSync(),
      duration: const Duration(milliseconds: 300),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: EmergencyPage(animationController: animationController),
      ),
    );

    // Wait for all animations and futures to complete.
    await tester.pumpAndSettle();

    // Verify that the EmergencyPage is displayed.
    expect(find.byType(EmergencyPage), findsOneWidget);
  });

  testWidgets('EmergencyPage displays and scrolls through all emergency items',
      (WidgetTester tester) async {
    // Create a mock AnimationController.
    final animationController = AnimationController(
      vsync: const TestVSync(),
      duration: const Duration(milliseconds: 300),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: EmergencyPage(animationController: animationController),
      ),
    );

    // Wait for all animations and futures to complete.
    await tester.pumpAndSettle();

    // Verify that all 8 emergency items are present and scrollable.
    for (int i = 0; i < 8; i++) {
      final itemFinder = find.byKey(Key('emergency_item_$i'));
      await tester.scrollUntilVisible(
        itemFinder,
        200.0,
        scrollable: find.byType(Scrollable),
      );
      await tester.pumpAndSettle();
      expect(itemFinder, findsOneWidget);
    }
  });

  testWidgets('tapping on an emergency item shows the alert dialog',
      (WidgetTester tester) async {
    // Create a mock AnimationController.
    final animationController = AnimationController(
      vsync: const TestVSync(),
      duration: const Duration(milliseconds: 300),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: EmergencyPage(animationController: animationController),
      ),
    );

    // Wait for all animations and futures to complete.
    await tester.pumpAndSettle();

    // Find the first emergency item.
    final firstItem = find.byKey(Key('emergency_item_0'));
    expect(firstItem, findsOneWidget);

    // Tap on the item.
    await tester.tap(firstItem);
    await tester.pumpAndSettle();

    // Verify that the dialog is shown.
    expect(find.byType(Dialog), findsOneWidget);
  });

  testWidgets('dialog shows correct content when an item is tapped',
      (WidgetTester tester) async {
    // Create a mock AnimationController.
    final animationController = AnimationController(
      vsync: const TestVSync(),
      duration: const Duration(milliseconds: 300),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: EmergencyPage(animationController: animationController),
      ),
    );

    // Wait for all animations and futures to complete.
    await tester.pumpAndSettle();

    // Tap on the first item.
    await tester.tap(find.byKey(Key('emergency_item_0')));
    await tester.pumpAndSettle();

    // Verify the dialog content.
    final dialogFinder = find.byType(Dialog);
    expect(dialogFinder, findsOneWidget);

    expect(
        find.descendant(
            of: dialogFinder, matching: find.text('Injuries & Fractures')),
        findsOneWidget);

    expect(
        find.descendant(
            of: dialogFinder, matching: find.byType(Image)),
        findsOneWidget);
  });

  testWidgets('description text field in dialog works correctly',
      (WidgetTester tester) async {
    // Create a mock AnimationController.
    final animationController = AnimationController(
      vsync: const TestVSync(),
      duration: const Duration(milliseconds: 300),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: EmergencyPage(animationController: animationController),
      ),
    );

    // Wait for all animations and futures to complete.
    await tester.pumpAndSettle();

    // Tap on the first item.
    await tester.tap(find.byKey(Key('emergency_item_0')));
    await tester.pumpAndSettle();

    // Find the text field.
    final textFieldFinder = find.byType(TextFormField);
    expect(textFieldFinder, findsOneWidget);

    // Enter text into the text field.
    await tester.enterText(textFieldFinder, 'This is a test description');
    await tester.pumpAndSettle();

    // Verify that the text was entered correctly.
    expect(find.text('This is a test description'), findsOneWidget);
  });
}
