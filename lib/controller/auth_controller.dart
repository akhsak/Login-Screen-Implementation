import 'package:datahex_login_task/model/user_model.dart';
import 'package:datahex_login_task/service/user_service.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isVisible = true;
  String? errorMessage;
  UserModel? userModel; // Added to store the user model

  void togglePasswordVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future<bool> login() async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      final authService = AuthService();
      final response = await authService.login(
        usernameController.text,
        passwordController.text,
      );

      // Store the user model
      userModel = response;

      isLoading = false;
      notifyListeners();
      return response.success;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearForm() {
    usernameController.clear();
    passwordController.clear();
    errorMessage = null;
    notifyListeners();
  }
}
