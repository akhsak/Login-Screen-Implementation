import 'package:datahex_login_task/model/user_model.dart';
import 'package:datahex_login_task/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final UserService _apiService = UserService();

  bool _isLoading = false;
  String _errorMessage = '';
  UserModel? _user;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  UserModel? get user => _user;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _apiService.login(email, password);

      _user = UserModel(
        email: email,
        token: response.data['token'],
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } on DioException catch (e) {
      _isLoading = false;

      if (e.response != null) {
        // Handle API errors
        _errorMessage =
            e.response?.data['detail'] ?? 'Login failed. Please try again.';
      } else {
        // Handle connection errors
        _errorMessage = 'Network error. Please check your connection.';
      }

      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred. Please try again.';
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }
}
