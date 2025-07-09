import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider();

  void login(String email, String password) {

  }

  void signUp(
    String userName,
    String email,
    String password
  ) {
    print('User: $userName, Email: $email, Password: $password');

  }
}