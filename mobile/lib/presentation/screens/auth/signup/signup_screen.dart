// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:tom_travel_app/logic/cubits/auth_cubit.dart';
import 'package:tom_travel_app/logic/states/auth_states.dart';
import 'package:tom_travel_app/presentation/widgets/app_background.dart';
import 'package:tom_travel_app/presentation/widgets/auth_button.dart';
import 'package:tom_travel_app/presentation/widgets/auth_fields.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
    String? emailError;
    //String? passwordError;

    
    return Scaffold(
      body: AppBackground(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {

            if (state is AuthLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Creating account...')),
              );
            } 
            else if (state is AuthSuccess) {
               _showSnack("Account created successfully!");
              Navigator.pushReplacementNamed(context, '/home');

            } 
            else if (state is AuthFailure) {
              if (state.message.contains('email has already been taken')) {
                emailError = 'This email is already registered.';
              } else if (state.message.contains('invalid credentials')) {
                emailError = 'Incorrect email or password.';
              } else {
                showDialog(context: context, builder: (context) => AlertDialog(
                  content: 
                  Text('Something went wrong. Please try again.', 
                       style: TextStyle(fontWeight: FontWeight.bold),), 
                  icon: Icon(Icons.error, size: 50, color: Colors.redAccent,)
                  )
                  );
              }

              // Trigger form re-validation
              _formKey.currentState!.validate();
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            
            return Stack(
            children: [
              // شكل نصف الدائرة البيضاء في الأعلى
              Positioned(
                top: -size.width * 0.5,
                left: -size.width * 0.1,
                child: Container(
                  width: size.width * 1.2,
                  height: size.width * 1.2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          
              // المحتوى الرئيسي
              SafeArea(
                child: Column(
                  children: [
                    // الشعار
                    Transform.translate(
                      offset: const Offset(0, 0), // ← تحريك للأعلى بمقدار 40px
                      child: Column(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 90,
                            child: SvgPicture.asset(
                              'assets/icons/secondary_blue_logo_icon.svg',
                            ),
                          ).animate()
                           .fade(duration: 1000.ms)
                            .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),
          
                          const SizedBox(height: 18),
          
                          Text(
                            'Join tom,',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.navyBlue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate()
                            .fade(duration: 600.ms, delay: 300.ms)
                            .slideY(begin: 0.2),
          
                          const SizedBox(height: 8),
          
                          Text(
                            'and  Start  Exploring!',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.navyBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ).animate()
                             .fade(duration: 600.ms, delay: 500.ms)
                             .slideY(begin: 0.2),
                        ],
                      ),
                    ),

                    const SizedBox(height: 90),

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
                                  label: 'Full Name',
                                  icon: Icons.person_outline,
                                  hint: 'Enter your full name',
                                  controller: _nameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                ).animate()
                                  .fade(duration: 600.ms, delay: 700.ms)
                                  .slideY(begin: 0.3),
                                      
                                const SizedBox(height: 20),
                                      
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
                                      if (emailError != null) {
                                        return emailError;
                                      }
                                      return null;
                                    },
                                  ).animate()
                                   .fade(duration: 600.ms, delay: 900.ms)
                                   .slideY(begin: 0.3),
                                      
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
                                  ).animate()
                                   .fade(duration: 600.ms, delay: 1100.ms)
                                   .slideY(begin: 0.3),
                                      
                                const SizedBox(height: 20),
                                      
                                buildField(
                                  label: 'Phone Number',
                                  icon: Icons.phone_android_outlined,
                                  hint: '+967 777-777-777',
                                  controller: _phoneController,
                                ).animate()
                                   .fade(duration: 600.ms, delay: 1300.ms)
                                   .slideY(begin: 0.3),
                                      
                                const SizedBox(height: 40),
                                      
                                // زر التسجيل
                                isLoading
                                      ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : buildButton(
                                        'Sign Up',
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context.read<AuthCubit>().register(
                                              _nameController.text.trim(),
                                              _emailController.text.trim(),
                                              _passwordController.text.trim(),
                                              _phoneController.text.trim(),
                                            );
                                          }
                                        },
                                      ).animate()
                                   .fade(duration: 700.ms, delay: 1500.ms)
                                   .scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOutBack),
                                      
                                const SizedBox(height: 30),
                                      
                                // أو تسجيل الدخول عبر
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 0.5,
                                      color: AppColors.white.withOpacity(0.5),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'or',
                                      style: AppTextStyles.button.copyWith(
                                        color: AppColors.white.withOpacity(0.5),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 150,
                                      height: 0.5,
                                      color: AppColors.white.withOpacity(0.5),
                                    ),
                                  ],
                                ).animate()
                                   .fade(duration: 600.ms, delay: 1600.ms)
                                   .slideY(begin: 0.3),
                                      
                                const SizedBox(height: 24),
                                      
                                // الأزرار الاجتماعية
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    socialButton('assets/icons/google.svg'),
                                    const SizedBox(width: 30),
                                    socialButton('assets/icons/apple.svg'),
                                  ],
                                ).animate()
                                   .fade(duration: 600.ms, delay: 1700.ms)
                                   .slideY(begin: 0.2),
                                      
                                const SizedBox(height: 24),
                                      
                                // لديك حساب؟
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: AppTextStyles.button.copyWith(
                                        color: AppColors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size(85, 30),
                                            tapTargetSize:
                                                MaterialTapTargetSize.shrinkWrap,
                                          ),
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context, '/login');
                                      },
                                      child: Text(
                                        'Login Here',
                                        style: AppTextStyles.button.copyWith(
                                          color: AppColors.lightBlue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ).animate()
                                   .fade(duration: 600.ms, delay: 1900.ms)
                                   .slideY(begin: 0.2),
                                      
                                const SizedBox(height: 10),
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
