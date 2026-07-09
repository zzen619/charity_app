import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String input, // 👈 بدل email
    required String password,
  }) async {
    emit(LoginLoading());

    await Future.delayed(const Duration(seconds: 2));

    /// 👇 تحديد Email أو Phone
    if (input.contains("@")) {
      // Email login
      if (input == "test@test.com" && password == "12345678") {
        emit(LoginSuccess());
      } else {
        emit(LoginError("Wrong email or password"));
      }
    } else {
      // Phone login
      if (input == "912345678" && password == "12345678") {
        emit(LoginSuccess());
      } else {
        emit(LoginError("Wrong phone or password"));
      }
    }
  }
}