import 'package:coffee_shop/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Cancel logout', (tester) async {
    // pump
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
    // find logout button and tap it
    final logoutButton = find.text('Logout');
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    // Before writing any other expectations based on the latest interaction, we should call tester.pump():
    // This will tell the Flutter engine to trigger a new frame.
    await tester.pump();

    // expect that the logout dialog is presented
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsOneWidget);

    // find cancel button and tap it
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
    await tester.tap(cancelButton);
    await tester.pump();

    // expect that the logout dialog is no longer visible
    expect(dialogTitle, findsNothing);
  });
}