// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:tom_travel_app/logic/cubits/auth_cubit.dart';
import 'package:tom_travel_app/logic/states/auth_states.dart';
import 'package:tom_travel_app/presentation/widgets/app_background.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String? userName;

    // جلب اسم المستخدم من الحالة
    final state = context.watch<AuthCubit>().state;
    if (state is AuthSuccess) {
      userName = state.user.name;
    }

    return Scaffold(
      body: AppBackground(
        child: Stack(
          children: [
            //  الدائرة البيضاء في الأعلى (ثابتة)
            Positioned(
              top: -size.width * 0.4,
              left: -size.width * 0.1,
              child: Container(
                width: size.width * 1.2,
                height: size.width * 1.2,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 80,
                    ),
                    child: Column(
                      children: [              
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      state is AuthSuccess &&
                                              state.user.profileImage != null
                                          ? NetworkImage(
                                            "http://192.168.0.109:8000/storage/${state.user.profileImage}",
                                          )
                                          : const AssetImage(
                                                'assets/icons/Avatar-Placeholder_icon.png',
                                              )
                                              as ImageProvider,
                                )

                          )
                        .animate()
                               .fade(duration: 400.ms, delay: 300.ms)
                                .slideY(begin: 0.2),
                        SizedBox(height: 12),
                        Text(
                          userName ?? 'User Name',
                          style: AppTextStyles.button.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                             color: AppColors.navyBlue,
                          ),
                        ).animate()
                      .fade(duration: 400.ms, delay: 500.ms)
                      .slideY(begin: 0.2),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),
                  
                  Expanded(
                    child: ListView(
                      children: [
                        _buildMenuItem(
                          context,
                          iconpath: 'assets/icons/id-card.svg',
                          title: 'Personal Information',
                          onTap: () {
                            Navigator.pushNamed(context, '/editprofile');
                          },
                        ).animate()
                            .fade(duration: 400.ms, delay: 700.ms)
                            .slideY(begin: 0.2),

                        _buildMenuItem(
                          context,
                          iconpath: 'assets/icons/my-review.svg',
                          title: 'My Reviews',
                          onTap: () {
                            // Navigate to card management page
                          },
                        ).animate()
                               .fade(duration: 400.ms, delay: 900.ms)
                               .slideY(begin: 0.2),

                        _buildMenuItem(
                          context,
                          iconpath: 'assets/icons/about.svg',
                          title: 'About',
                          onTap: () {
                            // Navigate to support page
                          },
                        ).animate()
                             .fade(duration: 400.ms, delay: 1100.ms)
                             .slideY(begin: 0.2),
                        
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 50,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.65),
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                       onPressed: () async {
                          await context.read<AuthCubit>().logout();

                          Navigator.pushNamedAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            '/login',
                            (route) => false,
                          );
                        },


                        child:  Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: ListTile(
                            leading: Icon(Icons.logout , color: Colors.white, size: 30,),
                            title: Text('Log out',
                            style: AppTextStyles.button.copyWith(fontSize: 20, color: Colors.white),
                                                ),
                                                ),
                        ),
                      ).animate()
                      .fade(duration: 400.ms, delay: 1300.ms)
                      .slideY(begin: 0.2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String iconpath,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ElevatedButton(       
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          onTap;
        },
        child: ListTile(
          leading: SvgPicture.asset(iconpath ,color: AppColors.white, width: 24 , height: 24,),
          title: Text(title , style: AppTextStyles.button.copyWith(color: AppColors.white,
            fontSize: 17 , fontWeight: FontWeight.w600)
            ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16 , color: AppColors.white,),
          onTap: onTap,
        ),
      ),
    );
  }
}
