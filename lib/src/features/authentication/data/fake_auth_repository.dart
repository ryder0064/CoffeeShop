import 'package:coffee_shop/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeAuthRepository {
  Stream<AppUser?> authStateChanges() => Stream.value(null); //TODO
  AppUser? get currentUser => null; //TODO

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    //TODO
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    //TODO
  }

  Future<void> signOut() async {
    //TODO
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  return FakeAuthRepository();
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
