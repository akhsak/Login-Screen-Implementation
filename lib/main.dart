// import 'package:datahex_login_task/login_screen.dart';
// import 'package:datahex_login_task/splash_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sign In UI',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         fontFamily: 'Roboto',
//       ),
//       home: SplashScreen(),
//       routes: {
//         '/signin': (context) => const SignInScreen(),
//       },
//     );
//   }
// }

import 'package:datahex_login_task/controller/auth_controller.dart';
import 'package:datahex_login_task/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        title: 'DataHex Login',
        theme: ThemeData(
          primaryColor: const Color(0xFF00D0A6),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00D0A6),
            primary: const Color(0xFF00D0A6),
          ),
          useMaterial3: true,
        ),
        home: const SignInScreen(),
      ),
    );
  }
}
