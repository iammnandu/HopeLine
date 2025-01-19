import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hopeline/presentation/disha/services/chat_service.dart';
import 'package:hopeline/presentation/disha/services/exercise_service.dart';
import 'package:hopeline/presentation/disha/services/insight_service.dart';
import 'package:hopeline/presentation/disha/services/strategy_service.dart';
import 'package:hopeline/presentation/homepage/main_screen.dart';
import 'package:hopeline/presentation/onBoarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Features - Music
import 'package:hopeline/features/music/data/datasources/song_remote_datasource.dart';
import 'package:hopeline/features/music/data/repository/song_repository_impl.dart';
import 'package:hopeline/features/music/domain/usecases/get_all_songs.dart';
import 'package:hopeline/features/music/presentation/bloc/song_bloc.dart';
import 'package:hopeline/features/music/presentation/bloc/song_event.dart';

// Features - Auth
import 'package:hopeline/features/authentication/providers/user_provider.dart';
import 'package:hopeline/features/authentication/services/auth_services.dart';

// Presentation
import 'package:hopeline/presentation/bottomNavBar/bloc/navigation_bloc.dart';
import 'package:hopeline/presentation/onBoarding/signup_screen.dart';
import 'package:hopeline/presentation/onBoarding/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  // Initialize services
  final exerciseService = ExerciseService(prefs);
  final insightService = InsightService(prefs);
  final strategyService = StrategyService();
  final chatService = ChatService();


  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Failed to load .env: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        Provider.value(value: exerciseService),
        Provider.value(value: insightService),
        Provider.value(value: strategyService),
        Provider.value(value: chatService),
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
    authService.getUserData(context);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _showSplash = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) => SongBloc(
            getAllSongs: GetAllSongs(
              repository: SongRepositoryImpl(
                remoteDataSource: SongRemoteDataSourceImpl(
                  client: http.Client(),
                ),
              ),
            ),
          )..add(FetchSongs()),
        )
      ],
      child: MaterialApp(
        title: 'Hopeline',
        theme: ThemeData(
          primaryColor: const Color(0xFF4CAF50),
          focusColor: const Color(0xFF388E3C),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF4CAF50),
            unselectedItemColor: Colors.grey,
            elevation: 8,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4CAF50),
            primary: const Color(0xFF4CAF50),
            secondary: const Color(0xFF388E3C),
            background: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: _showSplash
    ? const SplashScreen()
    : Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.user.token.isEmpty) {
            return const OnboardingScreen();
          }
          return MainScreen();
        },
      ),
        routes: {
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => MainScreen(),
        },
      ),
    );
  }
}
