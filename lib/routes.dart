import 'package:coding_challenge/screens/auth_page.dart';
import 'package:coding_challenge/screens/home_screen.dart';
import 'package:coding_challenge/screens/login_screen.dart';
import 'package:coding_challenge/screens/map_screen.dart';
import 'package:coding_challenge/screens/register_screen.dart';
import 'package:coding_challenge/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => Provider<AuthService>(
        create: (_) => AuthService(),
        child: AuthPage(),
      ),
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/map': (context) => MapScreen(),
};