import 'package:flutter/material.dart';
import 'package:hopeline/features/authentication/providers/user_provider.dart';
import 'package:hopeline/presentation/authentication/home_screen.dart';
import 'package:hopeline/presentation/onBoarding/onboarding_screen.dart';
import 'package:hopeline/presentation/onBoarding/signup_screen.dart';
import 'package:hopeline/features/authentication/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:hopeline/presentation/onBoarding/splash_screen.dart';

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
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for auth initialization
    authService.getUserData(context);
    
    // Show splash screen for minimum 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      setState(() {
        _showSplash = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hopeline',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      home: _showSplash 
        ? const SplashScreen()
        : Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.user.token.isEmpty) {
                return const OnboardingScreen();
              }
              return const HomeScreen();
            },
          ),
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}