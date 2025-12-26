import 'package:flutter/material.dart';

class AuthController {
  final email = TextEditingController();
  final password = TextEditingController();

  //  Email validation
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

  //  Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }



   
  }

