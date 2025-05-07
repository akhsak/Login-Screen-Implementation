import 'package:flutter/material.dart';
import 'package:datahex_login_task/model/user_model.dart';
import 'package:datahex_login_task/service/user_service.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isVisible = true;
  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _loginResponse;

  // Getters
  bool get isVisible => _isVisible;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get loginResponse => _loginResponse;

  // Toggle password visibility
  void togglePasswordVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  // Reset error message
  void resetError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Clear form fields
  void clearForm() {
    usernameController.clear();
    passwordController.clear();
    _errorMessage = null;
    notifyListeners();
  }

  // Perform login
  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.login(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      _loginResponse = response;
      _isLoading = false;
      notifyListeners();

      return _loginResponse != null;
    } catch (e) {
      _errorMessage = 'Login failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
