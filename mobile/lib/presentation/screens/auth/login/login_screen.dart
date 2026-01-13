// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:tom_travel_app/logic/cubits/auth_cubit.dart';
import 'package:tom_travel_app/logic/states/auth_states.dart';
import 'package:tom_travel_app/presentation/widgets/app_background.dart';
import 'package:tom_travel_app/presentation/widgets/auth_button.dart';
import 'package:tom_travel_app/presentation/widgets/auth_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSnack(String message, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.redAccent : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //String? emailError;
    //String? passwordError;

    return Scaffold(
      body: AppBackground(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              _showSnack("Login successful!");
              Navigator.pushReplacementNamed(context, '/home');

            } else if (state is AuthFailure) {
              _showSnack(state.message, error: true);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Stack(
              children: [
                Positioned(
                  top: -size.width * 0.4,
                  left: -size.width * 0.1,
                  child: Container(
                    width: size.width * 1.2,
                    height: size.width * 1.3,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 20),
                        child: Column(
                          children: [
                            SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: SvgPicture.asset(
                                    'assets/icons/secondary_blue_logo_icon.svg',
                                  ),
                                )
                                .animate()
                                .fade(duration: 1000.ms)
                                .slideY(begin: 0.3),
                            const SizedBox(height: 20),
                            Text(
                              'Welcome Back,',
                              style: AppTextStyles.subtitle.copyWith(
                                color: AppColors.navyBlue,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ).animate().fade(duration: 600.ms, delay: 300.ms),
                            const SizedBox(height: 8),
                            Text(
                              'your next adventure awaits!',
                              style: AppTextStyles.subtitle.copyWith(
                                color: AppColors.navyBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ).animate().fade(duration: 600.ms, delay: 500.ms),
                          ],
                        ),
                      ),
                      const SizedBox(height: 150),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 5,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  buildField(
                                    label: 'Email',
                                    icon: Icons.email_outlined,
                                    hint: 'Enter your email',
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      if (!value.contains('@')) {
                                        return 'Invalid email format';
                                      }
                                      return null;
                                    },
                                  ).animate().fade(duration: 600.ms, delay: 700.ms),

                                  const SizedBox(height: 20),

                                  buildField(
                                    label: 'Password',
                                    icon: Icons.lock_outline,
                                    hint: 'Enter your password',
                                    obscure: true,
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password is required';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ).animate().fade(duration: 600.ms, delay: 900.ms),

                                  const SizedBox(height: 0),

                                  // زر نسيت كلمة المرور
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: AppTextStyles.button.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ).animate()
                               .fade(duration: 600.ms, delay: 900.ms)
                               .slideY(begin: 0.3),

                            const SizedBox(height: 28),

                                  // زر تسجيل الدخول
                                  isLoading
                                      ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : buildButton(
                                        'Login',
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context.read<AuthCubit>().login(
                                              _emailController.text.trim(),
                                              _passwordController.text.trim(),
                                            );
                                          }
                                        },
                                      ).animate().fade(duration: 600.ms, delay: 1200.ms),

                                  const SizedBox(height: 40),

                                  // أو تسجيل الدخول عبر
                                  Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 150,
                                            height: 0.5,
                                            color: AppColors.white.withOpacity(
                                              0.5,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'or',
                                            style: AppTextStyles.button
                                                .copyWith(
                                                  color: AppColors.white
                                                      .withOpacity(0.5),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            width: 150,
                                            height: 0.5,
                                            color: AppColors.white.withOpacity(
                                              0.5,
                                            ),
                                          ),
                                        ],
                                      )
                                      .animate()
                                      .fade(duration: 600.ms, delay: 1200.ms)
                                      .slideY(begin: 0.3),

                                  const SizedBox(height: 24),

                                  // أزرار تسجيل الدخول الاجتماعية
                                  Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          socialButton(
                                            'assets/icons/google.svg',
                                          ),
                                          const SizedBox(width: 30),
                                          socialButton(
                                            'assets/icons/apple.svg',
                                          ),
                                        ],
                                      )
                                      .animate()
                                      .fade(duration: 600.ms, delay: 1300.ms)
                                      .slideY(begin: 0.2),

                                  const SizedBox(height: 32),

                                  // زر الانتقال إلى التسجيل
                                  Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Don't have an account?",
                                            style: AppTextStyles.button
                                                .copyWith(
                                                  color: AppColors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: const Size(100, 40),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(context, '/signup');
                                            },
                                            child: Text(
                                              'Sign Up Here',
                                              style: AppTextStyles.button
                                                  .copyWith(
                                                    color: AppColors.lightBlue,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      )
                                      .animate()
                                      .fade(duration: 600.ms, delay: 1500.ms)
                                      .slideY(begin: 0.2),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
