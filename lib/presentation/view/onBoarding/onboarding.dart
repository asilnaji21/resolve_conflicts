import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../bussiness logic/onboardingManager/on_boarding_cubit.dart';
import '../../../customwidget/button_custom.dart';
import '../../../data/models/onboarding_model.dart';
import '../../resources/color_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../resources/style_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.onBoardingColor,
        body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller,
                    onPageChanged: (value) {
                      context.read<OnBoardingCubit>().onSelectItem(value);
                    },
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        Image.asset(onboardingData[index].imagePath),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          onboardingData[state.currentIndex].title,
                          textAlign: TextAlign.center,
                          style: StyleManger.headline1(fontSize: 18),
                        ),
                        SizedBox(
                          height: 45,
                          child: Text(
                            onboardingData[state.currentIndex].description,
                            textAlign: TextAlign.center,
                            style: StyleManger.headline2(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: const ExpandingDotsEffect(
                              dotHeight: 10,
                              dotWidth: 16,
                              activeDotColor:
                                  ColorManager.primaryMainEnableColor,
                              dotColor: ColorManager.secondaryColor,
                              // type: WormType.thinUnderground,
                            ),
                          ),
                        ),
                        CustomButtonPrimary(
                          onPressed: () {
                            state.currentIndex == 2
                                ? NavigationManager.goToAndRemove(
                                    RouteConstants.loginRoute)
                                : controller.nextPage(
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.easeIn);
                          },
                          text: Text(state.currentIndex == 2
                              ? 'تسجيل الدخول'
                              : 'التالي'),
                        ),
                        TextButton(
                          onPressed: () {
                            NavigationManager.goToAndRemove(
                                RouteConstants.homeRoute);
                          },
                          style: TextButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50)),
                          child: Text(
                            'الدخول كزائر',
                            style: StyleManger.headline2(
                              color: ColorManager.primaryMainEnableColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
