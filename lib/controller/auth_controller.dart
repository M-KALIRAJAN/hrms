import 'package:flutter/material.dart';
import 'package:hrms/models/api_response.dart';
import 'package:hrms/models/auth_models.dart';
import 'package:hrms/services/auth_service.dart';

class AuthController {
  final email = TextEditingController();
  final password = TextEditingController();

  final AuthService _authService = AuthService();

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter valid email";
    }
    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  // LOGIN FLOW
  Future<ApiResponse> login() async {
    final authModel = AuthModel(
      email: email.text.trim(),
      password: password.text.trim(),
    );

    return await _authService.login(authModel);
  }

  // Dispose (important)
  void dispose() {
    email.dispose();
    password.dispose();
  }
}
