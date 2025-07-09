import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/constants/assets.dart';
import 'package:optikick/core/routes/routes.dart';
import 'package:optikick/core/widgets/gradient_background.dart';
import 'package:optikick/features/on_boarding/data/models/onboarding_model.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  static final List<OnboardingModel> onboardingImages = [
    OnboardingModel(
      image: Assets.imagesOnboarding2,
      title: 'Welcome to OptiKick',
      description: 'Optimizing your performance, one kick at a time.',
    ),
    OnboardingModel(
      image: Assets.imagesOnboarding1,
      title: 'Expert Analysis in Action',
      description:
          'Receive tailored recommendations to enhance your training and reach your goals..',
    ),
    OnboardingModel(
      image: Assets.imagesOnboarding3,
      title: 'Seamless Communication',
      description:
          'Stay connected with your team and get expert guidance instantly.',
    ),
  ];

  final PageController pageController = PageController();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesName.login);
                      },
                      child: Text(
                        'skip',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: onboardingImages.length,
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      currentPageIndex = index;
                    });
                  },
                  itemBuilder: (_, index) =>
                      buildnBoardingWidget(index, onboardingImages[index]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onboardingImages.length,
                            (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: currentPageIndex == index ? 12.w : 8.w,
                              height: currentPageIndex == index ? 12.w : 8.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPageIndex == index
                                    ? Colors.white
                                    : Colors.white.withAlpha(100),
                              ),
                            ),
                          ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        onPressed: () {
          if (currentPageIndex == onboardingImages.length - 1) {
            Navigator.pushReplacementNamed(context, RoutesName.login);
          } else {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Padding buildnBoardingWidget(int index, OnboardingModel onboardingModel) {
    return Padding(
      padding: EdgeInsets.only(left: index == 2 ? 30.w : 0),
      child: Column(
        children: [
          SizedBox(
            height: 370.h,
            child: Image.asset(
              onboardingModel.image,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            onboardingModel.title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 300.w,
            child: Text(
              onboardingModel.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
