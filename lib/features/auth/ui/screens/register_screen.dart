import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/features/auth/logic/register_cubit.dart';
import 'package:charity_app/features/auth/logic/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dateController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  File? profileImage;
  File? documentImage;

  int selectedDoc = -1;
  int selectedMethod = 0;
  int currentStep = 1;

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateController.text =
          "${picked.day}/${picked.month}/${picked.year}";
      setState(() {});
    }
  }

  Future<void> pickProfileImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = File(image.path);
      setState(() {});
    }
  }

  Future<void> pickDocumentImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      documentImage = File(image.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    dateController.text =
        "${now.day}/${now.month}/${now.year}";
  }

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
              child: currentStep == 1 ? buildStep1() : buildStep2(),
            ),
          ),
        ),
      ),
    );
  }

  /// STEP 1
  Widget buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text("Create New Account",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),

        const SizedBox(height: 20),

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

        sectionTitle("Personal Info"),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: firstNameController,
                label: "FIRST NAME",
                hint: "Ahmad",
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextField(
                controller: lastNameController,
                label: "LAST NAME",
                hint: "Zen",
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

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
                  maxLength: 9,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v!.isEmpty) return "Enter phone";
                    if (v.length != 9) return "9 digits";
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
              if (v!.isEmpty) return "Enter email";
              if (!v.contains("@")) return "Invalid email";
              return null;
            },
          ),

        const SizedBox(height: 20),

        CustomTextField(
          label: "DATE OF BIRTH",
          controller: dateController,
          readOnly: true,
          onTap: pickDate,
          suffixWidget: const Icon(Icons.calendar_today, color: Color(0xFF0F3D35)),
        ),

        const SizedBox(height: 20),

        CustomTextField(
          label: "ADDRESS",
          hint: "Enter address",
          suffixWidget: const Icon(Icons.location_on, color: Color(0xFF0F3D35)),
        ),

        const SizedBox(height: 30),

        sectionTitle("Profile Photo"),

        const SizedBox(height: 15),

        GestureDetector(
          onTap: pickProfileImage,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF0F3D35)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                profileImage != null
                    ? CircleAvatar(radius: 40, backgroundImage: FileImage(profileImage!))
                    : const Icon(Icons.camera_alt, size: 40, color: Color(0xFF0F3D35)),
                const SizedBox(height: 10),
                const Text("Upload a clear profile photo"),
              ],
            ),
          ),
        ),

        const SizedBox(height: 30),

        sectionTitle("Identity Document"),

        const SizedBox(height: 15),

        GestureDetector(
          onTap: () async {
            selectedDoc = 0;
            await pickDocumentImage();
            setState(() {});
          },
          child: buildDocItem("National ID", selectedDoc == 0),
        ),

        const SizedBox(height: 10),

        GestureDetector(
          onTap: () async {
            selectedDoc = 1;
            await pickDocumentImage();
            setState(() {});
          },
          child: buildDocItem("Passport", selectedDoc == 1),
        ),

        if (documentImage != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.file(documentImage!, height: 120),
          ),

        const SizedBox(height: 30),

        InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (selectedDoc == -1) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Select ID or Passport")),
                );
                return;
              }
              setState(() => currentStep = 2);
            }
          },
          child: buildButton("Next"),
        ),
      ],
    );
  }

  /// STEP 2
  Widget buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextButton(
          onPressed: () => setState(() => currentStep = 1),
          child: const Text("Back"),
        ),

        const SizedBox(height: 20),

        sectionTitle("Security Info"),

        const SizedBox(height: 10),

        const Text(
          "Create a strong password to protect your account",
          style: TextStyle(color: Color(0xFF0F3D35), fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        CustomTextField(
          controller: passwordController,
          label: "PASSWORD",
          obscureText: true,
          validator: (v) => v!.length < 8 ? "Min 8 chars" : null,
        ),

        const SizedBox(height: 20),

        CustomTextField(
          controller: confirmPasswordController,
          label: "CONFIRM PASSWORD",
          obscureText: true,
          validator: (v) =>
              v != passwordController.text ? "Passwords not match" : null,
        ),

        const SizedBox(height: 30),

        /// 🔥 FIXED HERE
        BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Registered Successfully ✅")),
              );
            }

            if (state is RegisterError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is RegisterLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  context.read<RegisterCubit>().register(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                }
              },
              child: buildButton("Create Account"),
            );
          },
        ),
      ],
    );
  }

  /// UI
  Widget sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFF0F3D35),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget buildToggle(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF0F3D35) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(color: selected ? Colors.white : Colors.black)),
      ),
    );
  }

  Widget buildButton(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F3D35),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget buildDocItem(String title, bool selected) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? const Color(0xFF0F3D35) : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.badge),
          const SizedBox(width: 10),
          Expanded(child: Text(title)),
          Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off),
        ],
      ),
    );
  }
}