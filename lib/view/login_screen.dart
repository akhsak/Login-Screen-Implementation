import 'package:datahex_login_task/controller/auth_controller.dart';
import 'package:datahex_login_task/widgets/alert_dialog_widget.dart';
import 'package:datahex_login_task/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    final isSmallScreen = screenWidth < 360;
    final headingSize =
        isSmallScreen ? 20.0 : (screenWidth > 600 ? 28.0 : 24.0);
    final subheadingSize =
        isSmallScreen ? 12.0 : (screenWidth > 600 ? 16.0 : 14.0);
    final standardSpacing =
        isSmallScreen ? 16.0 : (screenWidth > 600 ? 32.0 : 24.0);
    final smallSpacing = standardSpacing / 3;
    final buttonHeight =
        isSmallScreen ? 48.0 : (screenWidth > 600 ? 64.0 : 56.0);
    final cardPadding = EdgeInsets.all(
        isSmallScreen ? 16.0 : (screenWidth > 600 ? 32.0 : 24.0));

    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final isPortrait = constraints.maxHeight > constraints.maxWidth;

              return Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF00C19A),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                    child: CustomPaint(
                      painter: CirclePatternPainter(),
                    ),
                  ),
                  SafeArea(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight -
                              MediaQuery.of(context).padding.vertical,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Container(
                                height: isPortrait
                                    ? screenHeight * 0.45
                                    : screenHeight * 0.45,
                                alignment: Alignment.center,
                                child: Image.asset("assets/profile_image_.png"),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          isSmallScreen ? 20 : 30),
                                      topRight: Radius.circular(
                                          isSmallScreen ? 20 : 30),
                                    ),
                                  ),
                                  padding: cardPadding,
                                  child: Form(
                                    key: _loginKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Sign in',
                                            style: TextStyle(
                                                fontSize: headingSize,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: smallSpacing),
                                        Text(
                                            'Please enter your credentials to continue',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: subheadingSize)),
                                        SizedBox(height: standardSpacing),
                                        CustomTextField(
                                            controller: loginProvider
                                                .usernameController,
                                            hintText: 'Username',
                                            prefixIcon: Icons.person_outline,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (value) =>
                                                value == null || value.isEmpty
                                                    ? 'Enter a valid username'
                                                    : null),
                                        SizedBox(height: smallSpacing * 2),
                                        CustomTextField(
                                            controller: loginProvider
                                                .passwordController,
                                            hintText: 'Password',
                                            prefixIcon: Icons.lock_outline,
                                            obscureText:
                                                loginProvider.isVisible,
                                            suffixIcon: loginProvider.isVisible
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            suffixIconPressed: () =>
                                                loginProvider
                                                    .togglePasswordVisibility(),
                                            validator: (value) =>
                                                value == null || value.isEmpty
                                                    ? 'Enter a valid password'
                                                    : null),
                                        if (loginProvider.errorMessage != null)
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: smallSpacing),
                                              child: Text(
                                                  loginProvider.errorMessage!,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14))),
                                        SizedBox(
                                            height: isPortrait
                                                ? standardSpacing * 1.5
                                                : smallSpacing),
                                        Center(
                                          child: CustomButton(
                                              text: 'Sign in',
                                              onPressed: loginProvider.isLoading
                                                  ? null
                                                  : () async {
                                                      if (_loginKey
                                                          .currentState!
                                                          .validate()) {
                                                        final success =
                                                            await loginProvider
                                                                .login();
                                                        if (success) {
                                                          if (mounted) {
                                                            // Get userDisplayName from the stored model
                                                            final userDisplayName =
                                                                loginProvider
                                                                        .userModel
                                                                        ?.user
                                                                        .userDisplayName ??
                                                                    "User";
                                                            showSuccessDialog(
                                                                context,
                                                                userDisplayName);
                                                          }
                                                        } else {
                                                          if (mounted)
                                                            showErrorDialog(
                                                                context,
                                                                loginProvider
                                                                        .errorMessage ??
                                                                    'Login failed.');
                                                        }
                                                      }
                                                    },
                                              isLoading:
                                                  loginProvider.isLoading,
                                              width: screenWidth > 600
                                                  ? screenWidth * 0.5
                                                  : null,
                                              height: buttonHeight,
                                              fontSize: isSmallScreen
                                                  ? 14.0
                                                  : (screenWidth > 600
                                                      ? 18.0
                                                      : 16.0)),
                                        ),
                                        Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                                top: smallSpacing * 2),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Don't have an account?",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize:
                                                              isSmallScreen
                                                                  ? 12
                                                                  : 14)),
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: Text('Sign up',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF00C19A),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  isSmallScreen
                                                                      ? 12
                                                                      : 14)))
                                                ])),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
