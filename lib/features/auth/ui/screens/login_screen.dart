import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../logic/login_cubit.dart';
import '../../logic/login_state.dart';
import '../../../../core/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  int selectedMethod = 0; // 0 = phone , 1 = email

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 40),

                  const Text(
                    "Welcome Back 👋",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Login to your account",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  /// 🔥 TOGGLE
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedMethod = 0),
                          child: buildToggle("Phone Number", selectedMethod == 0),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedMethod = 1),
                          child: buildToggle("Email", selectedMethod == 1),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// 🔥 FIELD
                  if (selectedMethod == 0)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text("+963"),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            maxLength: 9,
                            validator: (v) {
                              if (v == null || v.isEmpty) return "Enter phone";
                              if (v.length != 9) return "9 digits only";
                              return null;
                            },
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: "9XXXXXXXX",
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    CustomTextField(
                      controller: emailController,
                      label: "EMAIL",
                      hint: "example@email.com",
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Enter email";
                        if (!v.contains("@")) return "Invalid email";
                        return null;
                      },
                    ),

                  const SizedBox(height: 20),

                  /// PASSWORD
                  CustomTextField(
                    controller: passwordController,
                    label: "PASSWORD",
                    obscureText: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Enter password";
                      if (v.length < 8) return "Min 8 chars";
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  /// LOGIN BUTTON
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Success ✅")),
                        );
                      } else if (state is LoginError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {

                            String input = selectedMethod == 0
                                ? phoneController.text
                                : emailController.text;

                            context.read<LoginCubit>().login(
                              input: input,
                              password: passwordController.text,
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F3D35),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  /// 🔥 REGISTER TEXT (مثل الصورة)
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push('/register');
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Color(0xFF0F3D35),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
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

  /// 🔥 TOGGLE UI
  Widget buildToggle(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF0F3D35) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}