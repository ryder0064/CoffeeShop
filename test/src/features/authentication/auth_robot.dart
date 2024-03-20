import 'package:coffee_shop/src/common_widgets/alert_dialogs.dart';
import 'package:coffee_shop/src/common_widgets/primary_button.dart';
import 'package:coffee_shop/src/features/authentication/data/fake_auth_repository.dart';
import 'package:coffee_shop/src/features/authentication/presentation/account/account_screen.dart';
import 'package:coffee_shop/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:coffee_shop/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class AuthRobot {
  AuthRobot(this.tester);

  final WidgetTester tester;

  Future<void> pumpEmailPasswordSignInContents({
    required FakeAuthRepository authRepository,
    required EmailPasswordSignInFormType formType,
    VoidCallback? onSignedIn,
  }) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: EmailPasswordSignInContents(
              formType: formType,
              onSignedIn: onSignedIn,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> tapEmailAndPasswordSubmitButton() async {
    final primaryButton = find.byType(PrimaryButton);
    expect(primaryButton, findsOneWidget);
    await tester.tap(primaryButton);
    await tester.pump();
  }

  Future<void> pumpAccountScreen({FakeAuthRepository? authRepository}) async {
    await tester.pumpWidget(ProviderScope(
      // To mock a dependency that is returned by a provider, we need to use a provider override
      overrides: [
        if (authRepository != null)
          authRepositoryProvider.overrideWithValue(
            authRepository,
          )
      ],
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

  void expectErrorAlertFound() {
    final finder = find.text('Error');
    expect(finder, findsOneWidget);
  }

  void expectErrorAlertNotFound() {
    final finder = find.text('Error');
    expect(finder, findsNothing);
  }

  void expectCircularProgressIndicator() {
    final finder = find.byType(CircularProgressIndicator);
    expect(finder, findsOneWidget);
  }
}
