import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_shop/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseFirestore _db;

  AuthProvider({
    required FirebaseFirestore db,
  }) : _db = db;

  UserModel? _user;
  bool isSignUpComplete = false;
  bool isLogIn = false;
  UserModel? get getUser => _user;
  String _errorMessage = 'Error en el servidor';

  Future<QuerySnapshot<Map<String, dynamic>>> _findUser({required String email, String password = 'findByEmail'}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    
    if (password == 'findByEmail') {
      querySnapshot = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
    } else {
      querySnapshot = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();
    }

    return querySnapshot;
  }

  Future<void> login(String email, String password) async {
    try {
      final querySnapshot = await _findUser(email: email, password: password);

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        // Assuming UserModel has a fromMap or fromJson constructor
        _user = UserModel.fromMap(userData);
      } else {
        _errorMessage = 'Usuario o contraseña incorrectos';
        throw ErrorHint(_errorMessage);
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);

      isLogIn = true;
      notifyListeners();
    } catch (e) {
      throw ErrorHint(_errorMessage);
    }
  }

  Future<void> signUp(UserModel user) async {
    try {
      _user = user;

      final querySnapshot = await _findUser(email: user.getEmail);

      if (querySnapshot.docs.isNotEmpty) {
        _errorMessage = 'El usuario ya existe';
        throw ErrorHint(_errorMessage);
      }

      Map<String, dynamic> userData = {
        'name': user.getUserName,
        'email': user.getEmail,
        'password': user.getPassword,
        'registrationTokenList': user.getRegistrationTokenList
      };

      await _db.collection('users').add(userData);

      isSignUpComplete = true;
      notifyListeners();
    } catch (e) {
      throw ErrorHint(_errorMessage);
    }
  }

  void resetFlags() {
    isSignUpComplete = false;
    isLogIn = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    isLogIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    notifyListeners();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    if (email != null) {
      final query = await _db.collection('users').where('email', isEqualTo: email).get();
      if (query.docs.isNotEmpty) {
        _user = UserModel.fromMap(query.docs.first.data());
        isLogIn = true;
        notifyListeners();
      }
    }
  }
}