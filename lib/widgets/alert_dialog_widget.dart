import 'package:datahex_login_task/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showSuccessDialog(BuildContext context, String userDisplayName) {
  // Get screen size
  final screenSize = MediaQuery.of(context).size;
  final isSmallScreen = screenSize.width < 360;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF00D0A6).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                color: const Color(0xFF00D0A6),
                size: isSmallScreen ? 36 : 48,
              ),
            ),
            SizedBox(height: isSmallScreen ? 16.0 : 24.0),
            Text(
              'Login Success',
              style: TextStyle(
                fontSize: isSmallScreen ? 18 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isSmallScreen ? 6.0 : 8.0),
            Text(
              'Welcome $userDisplayName',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: isSmallScreen ? 6.0 : 8.0),
            Text(
              'You have successfully logged in',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: isSmallScreen ? 16.0 : 24.0),
            SizedBox(
              width: double.infinity,
              height: isSmallScreen ? 40 : 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Clear the form fields after successful login
                  Provider.of<LoginProvider>(context, listen: false)
                      .clearForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D0A6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xFFFDEDEC),
        title: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 8),
            const Text('Login Error', style: TextStyle(color: Colors.red)),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
