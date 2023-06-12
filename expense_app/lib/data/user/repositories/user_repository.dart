import '../datasources/remote_api/user_login.dart';
import '../datasources/remote_api/user_register.dart';
import '../models/user_model.dart';

class UserRepository {
  final UserLoginDataSource _UserLoginDataSource;
  final UserRegisterDataSource _UserRegisterDataSource;

  UserRepository(this._UserLoginDataSource, this._UserRegisterDataSource);

  Future<bool> login(String email, String password) async {
    return _UserLoginDataSource.login(email, password);
  }

  Future<bool> register(UserModel user) async {
    return _UserRegisterDataSource.register(
      user.firstName,
      user.lastName,
      user.email,
      user.password,
    );
  }
}
