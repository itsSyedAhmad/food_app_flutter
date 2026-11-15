import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AuthRepo {
  static const _usersKey = 'mock_auth_users_json';

  Future<User> signIn({required String email, required String password}) async {
    final users = await _readUsers();
    final normalizedEmail = email.trim().toLowerCase();

    for (final user in users) {
      if (user['email'] == normalizedEmail && user['password'] == password) {
        return User.fromJson(user);
      }
    }

    throw const AuthException('Email or password is incorrect.');
  }

  Future<User> signUp({
    required String email,
    required String password,
    required String fullName,
    required String mobileNumber,
    required String dateOfBirth,
  }) async {
    final users = await _readUsers();
    final normalizedEmail = email.trim().toLowerCase();

    if (users.any((user) => user['email'] == normalizedEmail)) {
      throw const AuthException('An account with this email already exists.');
    }

    final newUser = <String, dynamic>{
      'email': normalizedEmail,
      'password': password,
      'fullName': fullName.trim(),
      'mobileNumber': mobileNumber.trim(),
      'dateOfBirth': dateOfBirth,
    };
    users.add(newUser);

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_usersKey, jsonEncode(users));

    return User.fromJson(newUser);
  }

  Future<List<Map<String, dynamic>>> _readUsers() async {
    final preferences = await SharedPreferences.getInstance();
    final storedJson = preferences.getString(_usersKey);
    if (storedJson == null || storedJson.isEmpty) return [];

    final decoded = jsonDecode(storedJson) as List<dynamic>;
    return decoded
        .map((user) => Map<String, dynamic>.from(user as Map))
        .toList();
  }
}
