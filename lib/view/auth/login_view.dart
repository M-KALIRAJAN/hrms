import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms/controller/auth_controller.dart';
import 'package:hrms/core/constants/app_colors.dart';
import 'package:hrms/models/auth_models.dart';
import 'package:hrms/routing/app_router.dart';
import 'package:hrms/services/auth_service.dart';
import 'package:hrms/storage/preferences.dart';
import 'package:hrms/widgets/app_button.dart';
import 'package:hrms/widgets/app_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _authController = AuthController();
  final _authService = AuthService();
  bool _obscure = true;
  bool _isLoading = false;

  // Animation controllers
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Future<void> _Login(BuildContext context) async {
  //   if (!_formKey.currentState!.validate()) return;

  //   setState(() => _isLoading = true);

  //   final authData = AuthModel(
  //     email: _authController.email.text.trim(),
  //     password: _authController.password.text.trim(),
  //   );

  //   final success = await _authService.login(authData);

  //   setState(() => _isLoading = false);
  //   if (!mounted) return;
  //   if (success) {
  //     await Preferences.setLoggedIn(true);
  //     context.go(RouteName.home);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Login failed")),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: size.width > 400 ? 400 : size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/sarasbig.png',
                        height: 100, // adjust size as needed
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 10),
                      const Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppTextfield(
                        controller: _authController.email,
                        label: "Email",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        validator: _authController.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      AppTextfield(
                        controller: _authController.password,
                        label: "Password",
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.lock,
                        validator: _authController.validatePassword,
                        obscureText: _obscure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      AnimatedScale(
                        scale: _isLoading ? 0.95 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: AppButton(
                          height: 50,
                          width: double.infinity,
                          text: "Login",
                          color: AppColors.btn_primery,
                          textColor: Colors.white,
                          isLoading: _isLoading,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await _authController.login();
                              if (response.success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(response.message),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                context.go(RouteName.home);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(response.message),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
