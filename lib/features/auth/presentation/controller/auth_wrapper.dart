import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starzinfinite/features/auth/presentation/controller/auth_provider.dart';

import '../pages.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authState = Provider.of<AuthState>(context, listen: false);
    bool loggedIn = await authState.tryLogin();

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    if (!loggedIn) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);

    if (_isLoading) {
      return const SplashScreen();
    } else {
      return authState.isAuthorized ? const HomeScreen() : const LoginPage();
    }
  }
}
