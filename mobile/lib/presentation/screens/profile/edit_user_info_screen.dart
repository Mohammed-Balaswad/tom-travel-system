// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:tom_travel_app/logic/cubits/auth_cubit.dart';
import 'package:tom_travel_app/logic/states/auth_states.dart';
import 'package:tom_travel_app/presentation/widgets/app_background.dart';
import 'package:tom_travel_app/presentation/widgets/auth_button.dart';
import 'package:tom_travel_app/presentation/widgets/auth_fields.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? selectedImagePath; 

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file =
        await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        selectedImagePath = file.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final state = context.read<AuthCubit>().state;
    // تحديث الحقول النصية بالقيمة المحفوظة في الحالة
    if (state is AuthSuccess) {
      _nameController.text = state.user.name;
      _emailController.text = state.user.email;
      _phoneController.text = state.user.phone ?? "";
      selectedImagePath = state.user.profileImage;

    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: AppTextStyles.button.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.navyBlue,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.navyBlue),
         onPressed: () {
          Navigator.pop(context);
          }

        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),

      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully") , backgroundColor: Colors.green,),
            );
            Navigator.pop(context);
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message) , backgroundColor: Colors.red,),
            );
          }
        },

        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return AppBackground(
            child: Stack(
              children: [
                Positioned(
                  top: -size.width * 0.4,
                  left: -size.width * 0.1,
                  child: Container(
                    width: size.width * 1.2,
                    height: size.width * 0.95,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.width * 0.6),
                        topRight: Radius.circular(size.width * 0.6),
                        bottomLeft: Radius.circular(size.width * 0.25),
                        bottomRight: Radius.circular(size.width * 0.25),
                      ),
                    ),
                  ),
                ),

                SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      // الصورة الأساسية
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              selectedImagePath != null
                                  ? FileImage(
                                    File(selectedImagePath!),
                                  ) 
                                  : (context.read<AuthCubit>().state
                                          is AuthSuccess &&
                                      (context.read<AuthCubit>().state
                                                  as AuthSuccess)
                                              .user
                                              .profileImage !=
                                          null)
                                  ? NetworkImage(
                                        (context.read<AuthCubit>().state
                                                as AuthSuccess)
                                            .user
                                            .profileImage!,
                                      )
                                      as ImageProvider // صورة من السيرفر
                                  : const AssetImage(
                                    'assets/icons/Avatar-Placeholder_icon.png',
                                  ),
                                                ),
                        ),

                      // زر الكاميرا 
                      Positioned(
                        bottom: -2,
                        right: -2,
                        child: GestureDetector(
                          onTap: pickImage, 
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.navyBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 150),

                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                buildField(
                                  label: 'Full Name',
                                  icon: Icons.person_outline,
                                  hint: 'Enter your name',
                                  controller: _nameController,
                                  validator: (v) =>
                                      v == null || v.isEmpty ? 'Required' : null,
                                ).animate().fade().slideY(begin: 0.3),

                                const SizedBox(height: 20),

                                buildField(
                                  label: 'Email',
                                  icon: Icons.email_outlined,
                                  hint: 'Enter email',
                                  controller: _emailController,
                                  validator: (v) =>
                                      v == null || !v.contains('@')
                                          ? 'Invalid Email'
                                          : null,
                                ).animate().fade().slideY(begin: 0.3),

                                const SizedBox(height: 20),

                                buildField(
                                  label: 'Phone Number',
                                  icon: Icons.phone_android_outlined,
                                  hint: '+967 777 777 777',
                                  controller: _phoneController,
                                ).animate().fade().slideY(begin: 0.3),

                                const SizedBox(height: 40),

                                isLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : buildButton(
                                        'Save Changes',
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            context.read<AuthCubit>().updateProfile(
                                                  name: _nameController.text.trim(),
                                                  email: _emailController.text.trim(),
                                                  phone: _phoneController.text.trim(),
                                                  imagePath: selectedImagePath,
                                                );
                                          }
                                        },
                                      ).animate().fade().scale(),

                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ),

                     
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
