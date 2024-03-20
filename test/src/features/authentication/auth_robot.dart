import 'package:coffee_shop/src/common_widgets/alert_dialogs.dart';
import 'package:coffee_shop/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class AuthRobot {
  AuthRobot(this.tester);

  final WidgetTester tester;

  Future<void> pumpAccountScreen() async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp.router(
        routerConfig: GoRouter(initialLocation: '/', routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const AccountScreen(),
          ),
        ]),
      ),
    ));
  }

  Future<void> tapLogoutButton() async {
    final logoutButton = find.text('Logout');
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    // Before writing any other expectations based on the latest interaction, we should call tester.pump():
    // This will tell the Flutter engine to trigger a new frame.
    await tester.pump();
  }

  void expectLogoutDialogFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsOneWidget);
  }

  Future<void> tapCancelButton() async {
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
    await tester.tap(cancelButton);
    await tester.pump();
  }

  void expectLogoutDialogNotFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsNothing);
  }

  Future<void> tapDialogLogoutButton() async {
    final logoutButton = find.byKey(kDialogDefaultKey);
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pump();
  }
}
