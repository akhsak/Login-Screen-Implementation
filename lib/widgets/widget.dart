import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconPressed;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.suffixIconPressed,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(
                    suffixIcon,
                    color: Colors.grey,
                  ),
                  onPressed: suffixIconPressed,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

//bttoun

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final double fontSize;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 56.0,
    this.fontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C19A),
          disabledBackgroundColor: const Color(0xFF00C19A).withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

//background circle

class CirclePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 121, 237, 214)
          .withOpacity(0.3) // Slightly darker green with transparency
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          size.width * 0.11; // Scale stroke width based on screen width

    // Draw large circles in the background
    final centerX = size.width * 0.5;
    final centerY = size.height * 0.18; // Positioned at the top section

    // Draw multiple concentric circles
    for (int i = 0; i < 3; i++) {
      double radius = size.width * (0.25 + i * 0.25);
      canvas.drawCircle(Offset(centerX, centerY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
