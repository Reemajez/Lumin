import 'package:flutter/material.dart';
import 'package:lumin_application/Screens/home/home_page.dart';
import 'package:lumin_application/Screens/signup.dart';

import '../Widgets/gradient_background.dart';
import '../theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  static const double _gap12 = 12;
  static const double _gap16 = 16;
  static const double _gap20 = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/Lumin_logo.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 20),

                  // Title
                  const Text(
                    'Sign in to your\nAccount',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Subtitle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignupPage()),
                          );
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: AppColors.button,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: _gap20),

                  // Email
                  _field(
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white, // ✅ النص أبيض
                        fontWeight: FontWeight.w600,
                      ),
                      cursorColor: Colors.white, // ✅ المؤشر أبيض
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                  ),

                  const SizedBox(height: _gap12),

                  // Password
                  _field(
                    TextField(
                      obscureText: _obscurePassword,
                      style: const TextStyle(
                        color: Colors.white, // ✅ النص أبيض
                        fontWeight: FontWeight.w600,
                      ),
                      cursorColor: Colors.white, // ✅ المؤشر أبيض
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Colors.white54,
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => _obscurePassword = !_obscurePassword),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: _obscurePassword
                                ? Colors.white54
                                : AppColors.button,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: _gap12),

                  // Forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forgot password? ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignupPage()),
                          );
                        },
                        child: const Text(
                          'Click here',
                          style: TextStyle(
                            color: AppColors.button,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: _gap20),

                  // Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                        );
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
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
    );
  }

  Widget _field(Widget child) => SizedBox(height: 50, child: child);
}