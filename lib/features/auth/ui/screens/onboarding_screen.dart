import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2),
      body: SafeArea(
        child: Stack(
          children: [
            /// 🔹 الخلفية
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F1EF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),

            /// 🔹 Header (ATAA + Skip)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Spacer(),
                  Text("ATAA", style: AppTextStyles.title(context)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      _controller.jumpToPage(2);
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Color(0xFF0F3D35)),
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 Card
            Align(
              alignment: const Alignment(0, 0.15),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// 🔥 PageView
                    SizedBox(
                      height: 360,
                      child: PageView(
                        controller: _controller,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        children: [
                          buildPage(
                            image: 'assets/images/onboarding_screen.png',
                            title: "Welcome to ATAA",
                            desc:
                                "A charitable platform dedicated to supporting orphans, patients, and students in need.",
                          ),
                          buildPage(
                            image: 'assets/images/onboarding_screen.png',
                            title: "We Care for Those in Need",
                            desc:
                                "We support orphaned children and help patients and students continue their journey.",
                          ),
                          buildLastPage(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// 🔹 Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentIndex == index ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index == currentIndex
                                ? const Color(0xFF0F3D35)
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    /// 🔥 Bottom Buttons
                    if (currentIndex == 0)
                      CustomButton(
                        label: "Get Started",
                        height: 55,
                        backgroundColor: const Color(0xFF0F3D35),
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),

                    if (currentIndex == 1)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _controller.previousPage(
                                  duration:
                                      const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const Text("Back"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              label: "Next",
                              height: 55,
                              backgroundColor: const Color(0xFF0F3D35),
                              onTap: () {
                                _controller.nextPage(
                                  duration:
                                      const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                    if (currentIndex == 2)
                      Column(
                        children: [
                          CustomButton(
                            label: "Create an Account",
                            height: 55,
                            backgroundColor: const Color(0xFF0F3D35),
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Already have an account? Sign In",
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 الصفحات العادية
  Widget buildPage({
    required String image,
    required String title,
    required String desc,
  }) {
    return Column(
      children: [
        Image.asset(image, height: 180),
        const SizedBox(height: 20),
        Text(title, style: AppTextStyles.title(context)),
        const SizedBox(height: 10),
        Text(desc, textAlign: TextAlign.center),
      ],
    );
  }

  /// 🔥 الصفحة الثالثة مع الأزرار
  Widget buildLastPage() {
    return Column(
      children: [
        Image.asset('assets/images/onboarding_screen.png', height: 180),

        const SizedBox(height: 20),

        Text("Join the Change", style: AppTextStyles.title(context)),

        const SizedBox(height: 10),

        Text(
          "Volunteer on the ground, donate to a cause, or submit a request for assistance.",
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 20),

        /// 🔥 الأزرار الثلاثة
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {},
              child: const Text("Volunteer"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF4B860),
              ),
              onPressed: () {},
              child: const Text("Donate"),
            ),
          ],
        ),

        const SizedBox(height: 10),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            foregroundColor: Colors.black,
          ),
          onPressed: () {},
          child: const Text("Request Help"),
        ),
      ],
    );
  }
}