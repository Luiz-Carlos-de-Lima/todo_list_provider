import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

import 'user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;

  UserServiceImpl({required UserRepository userRepository}) : this._userRepository = userRepository;

  //funcao é apenas um proxy, pois a camada de repositorio deve passar pela camada de service para ir para a controller da tela.
  Future<User?> register({required String email, required String password}) async {
    return await _userRepository.register(email: email, password: password);
  }

  Future<User?> login({required String email, required String password}) async {
    return await _userRepository.login(email: email, password: password);
  }

  @override
  Future<void> recoverPassword({required String email}) async {
    await _userRepository.recoverPassword(email: email);
  }
}
