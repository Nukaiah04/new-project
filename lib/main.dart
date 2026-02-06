import 'package:flutter/material.dart';
import 'package:merchant_bill/Controllers/AuthenticationController.dart';
import 'package:merchant_bill/Controllers/CategoryController.dart';
import 'package:merchant_bill/Controllers/ItemsController.dart';
import 'package:merchant_bill/Controllers/OrdersController.dart';
import 'package:merchant_bill/Views/LandingView.dart';
import 'package:merchant_bill/Views/LoginView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => AuthenticationController()),
    ChangeNotifierProvider(create: (ctx) => CategoryController()),
    ChangeNotifierProvider(create: (ctx) => ItemsController()),
    ChangeNotifierProvider(create: (ctx) => OrdersController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthWrapper(),
        '/home': (context) => AuthGuard(child: const LandingView()),
        '/login': (context) => const LoginView(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => AuthGuard(child: const LoginView()));
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check authentication status
    return FutureBuilder<String?>(
      future: getAuthToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          // Auth token exists, navigate to Home
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/home');
          });
        } else {
          // No auth token, navigate to Login
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/login');
          });
        }

        // Return a loading indicator until the Future completes
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class AuthGuard extends StatelessWidget {
  final Widget child;

  AuthGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return child;
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/login');
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

Future<String?> getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<bool> isAuthenticated() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  return token != null;
}
