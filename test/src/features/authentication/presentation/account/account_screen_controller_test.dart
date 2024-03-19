@Timeout(Duration(milliseconds: 500))
import 'package:coffee_shop/src/features/authentication/data/fake_auth_repository.dart';
import 'package:coffee_shop/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  late MockAuthRepository authRepository;
  late AccountScreenController controller;
  setUp(() {
    authRepository = MockAuthRepository();
    controller = AccountScreenController(
      authRepository: authRepository,
    );
  });

  group('AccountScreenController', () {
    test('initial state is AsyncValue.data', () {
      verifyNever(authRepository.signOut);
      expect(controller.state, const AsyncData<void>(null));
    });

    /*
    * Testing each individual state change inside our StateNotifier subclass:
    * Using expectLater before calling the code under test
    * Using predicates to write fine-grained expectations
    * Adding a custom timeout to ensure our tests fail fast when needed
    * */
    test(
      'signOut success',
      () async {
        // setup
        when(authRepository.signOut).thenAnswer(
          (_) => Future.value(),
        );

        // Streams emit values over time, meaning that by the time we call expect, all the values have already been emitted, and it's too late to check them.
        // Instead, we need to start observing our stream before it emits any value.
        // In other words, we need to expect that our stream will emit some values before we call controller.signOut().
        expectLater(
          controller.stream,
          emitsInOrder(const [
            AsyncLoading<void>(),
            AsyncData<void>(null),
          ]),
        );
        // run
        await controller.signOut();
        // verify
        verify(authRepository.signOut).called(1);
      },
    );
    test(
      'signOut failure',
      () async {
        // setup
        final exception = Exception('Connection failed');
        when(authRepository.signOut).thenThrow(exception);

        // AsyncValue.guard will capture both the exception and the stack trace when creating the output AsyncError state.
        // But on our test we can't create an expected value with a matching stack trace, so we need to test with predicates.
        // This allows us to write fine-grained expectations by checking if we have an error without worrying about the properties we don't care about (such as the stack trace in this case).
        expectLater(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            predicate<AsyncValue<void>>((value) {
              expect(value.hasError, true);
              return true;
            }),
          ]),
        );
        // run
        await controller.signOut();
        // verify
        verify(authRepository.signOut).called(1);
      },
    );
  });
}
