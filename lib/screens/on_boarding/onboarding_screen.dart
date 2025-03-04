import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/screens/on_boarding/taking_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc for handling onboarding state
class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void changePage(int index) => emit(index);
}

// Onboarding screen with PageView
class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: Scaffold(
        backgroundColor: AppTheme.offWhite,
        body: OnboardingView(),
      ),
    );
  }
}

class OnboardingView extends StatelessWidget {
  final PageController _pageController = PageController();

  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/onb_1.png",
      "title": "Find Best Meal Plans Around You",
      "subtitle":
          "Get the best subscription-based meal plans designed for busy professionals and students.",
    },
    {
      "image": "assets/images/onb_2.png",
      "title": "Fast & Reliable Food Delivery",
      "subtitle":
          "Never worry about cooking again—enjoy fresh, homemade meals delivered daily to your doorstep.",
    },
    {
      "image": "assets/images/onb_3.png",
      "title": "Customize Your Meal Preferences",
      "subtitle":
          "Choose from flexible packages that match your dietary needs and budget.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) =>
                    context.read<OnboardingCubit>().changePage(index),
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    image: pages[index]["image"]!,
                    title: pages[index]["title"]!,
                    subtitle: pages[index]["subtitle"]!,
                    currentIndex: state,
                    totalPages: pages.length,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: state < pages.length - 1
                    ? [
                        // Next Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.lavender,
                            foregroundColor: AppTheme.darkGray,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12),
                          ),
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Text("Next"),
                        ),
                      ]
                    : [
                        // Get Started Button (Only on last page)
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.lavender,
                              foregroundColor: AppTheme.darkGray,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 30),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TakingInformationScreen()),
                              );
                            },
                            child: const Text("Get Started"),
                          ),
                        ),
                      ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// Widget for individual onboarding pages
class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final int currentIndex;
  final int totalPages;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Image.asset(image),
          ),
          const SizedBox(height: 20),

          // Indicator Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: currentIndex == index ? 20 : 8,
                decoration: BoxDecoration(
                  color:
                      currentIndex == index ? AppTheme.darkGray : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTheme.textTheme.displaySmall,
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTheme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
