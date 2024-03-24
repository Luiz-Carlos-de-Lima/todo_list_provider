import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  //Modelo que vai vir do proprio firebase
  Future<User?> register({required String email, required String password});
}
