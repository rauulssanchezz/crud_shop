import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_shop/domain/model/user.dart';
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

  Future<void> login(String email, String password) async {
    try {
      final querySnapshot = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        // Assuming UserModel has a fromMap or fromJson constructor
        _user = UserModel.fromMap(userData);
      } else {
        throw Exception('User not found');
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);

      isLogIn = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(UserModel user) async {
    try {
      _user = user;

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
      rethrow;
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