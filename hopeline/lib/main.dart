import 'package:flutter/material.dart';
import 'package:hopeline/providers/user_provider.dart';
import 'package:hopeline/screens/home_screen.dart';
import 'package:hopeline/screens/signup_screen.dart';
import 'package:hopeline/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Node Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider.of<UserProvider>(context).user.token.isEmpty ? const SignupScreen() : const HomeScreen(),
    );
  }
}