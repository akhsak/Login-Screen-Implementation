import 'package:datahex_login_task/model/user_model.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class AuthService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://entrance-test-api.datahex.co/api/v1/auth/login/';

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      log('Response Status Code: ${response.statusCode}');
      log('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        log('Login failed with status code: ${response.statusCode}');
        log('Login failed with status message: ${response.statusMessage}');
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Changed from catch (e) to on DioException catch (e)
      // Handle Dio specific errors
      log('Dio Error: ${e.message}');
      log('Dio Error Type: ${e.type}');
      log('Dio Error Response: ${e.response?.data}');
      log('Dio Error Stacktrace: ${e.stackTrace}');

      if (e.type == DioExceptionType.connectionError) {
        // Handle connection errors specifically
        throw Exception(
          'Failed to connect to the server. Please check your internet connection.',
        );
      } else {
        throw Exception('Dio error during login: ${e.message}');
      }
    } catch (e) {
      // Handle other types of errors
      log('Error: ${e.toString()}');
      rethrow;
    }
  }
}
