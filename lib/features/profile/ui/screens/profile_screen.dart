import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../logic/cubit/profile_cubit.dart';
import '../../logic/state/profile_state.dart';
import '../../../../core/router/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  ImageProvider<Object> buildProfileImage(String image) {
    if (image.isEmpty) {
      return const AssetImage('assets/images/default_avatar.png');
    }
    if (image.startsWith('http')) {
      return NetworkImage(image);
    }
    return FileImage(File(image));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2),
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      /// HEADER
                      Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 10),
                          Text(
                            "Profile",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      /// AVATAR
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: buildProfileImage(state.image),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit, size: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      /// NAME
                      Text(
                        state.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F3D35),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Impact Member since 2022",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 25),

                      /// 💰 WALLET
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0F3D35), Color(0xFF145A50)],
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("My Wallet", style: TextStyle(color: Colors.white70)),
                            const SizedBox(height: 10),
                            Text(
                              "\$${state.walletBalance.toStringAsFixed(0)}",
                              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<ProfileCubit>().addMoney(50);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                      child: const Center(
                                        child: Text("Add Money", style: TextStyle(color: Color(0xFF0F3D35), fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<ProfileCubit>().withdraw(30);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(12)),
                                      child: const Center(
                                        child: Text("Withdraw", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      /// MENU ITEMS
                      buildMenuItem(
                        icon: Icons.volunteer_activism,
                        title: "My Activities",
                        onTap: () {
                          context.push('${AppRoutes.profile}/${AppRoutes.myActivities}');
                        },
                      ),
                      buildMenuItem(
                        icon: Icons.favorite,
                        title: "My Donations",
                        onTap: () {
                          context.push('${AppRoutes.profile}/${AppRoutes.myImpact}');
                        },
                      ),
                      buildMenuItem(
                        icon: Icons.person,
                        title: "Edit Profile",
                        onTap: () {
                          context.push(
                            '${AppRoutes.profile}/${AppRoutes.editProfile}',
                            extra: {
                              'name': state.name,
                              'image': state.image,
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      /// LOGOUT BUTTON
                      GestureDetector(
                        onTap: () {
                          context.read<ProfileCubit>().logout();
                          context.go(AppRoutes.login);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(14)),
                          child: const Center(
                            child: Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: Text("Error loading profile"));
          },
        ),
      ),
    );
  }

  /// 🔹 MENU ITEM WIDGET
  Widget buildMenuItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFFE8F3F1), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: const Color(0xFF0F3D35)),
            ),
            const SizedBox(width: 15),
            Expanded(child: Text(title)),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}