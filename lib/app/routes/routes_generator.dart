import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/route_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bussiness logic/authCubit/auth_cubit.dart';
import '../../bussiness logic/onboardingManager/on_boarding_cubit.dart';
import '../../presentation/view/authentication/email_opt_screen.dart';
import '../../presentation/view/authentication/emailconfirmation_view.dart';
import '../../presentation/view/authentication/emailverification_view.dart';
import '../../presentation/view/authentication/login_view.dart';
import '../../presentation/view/authentication/newpassword_view.dart';
import '../../presentation/view/authentication/restorepassword_view.dart';
import '../../presentation/view/authentication/signup_view.dart';
import '../../presentation/view/bnb/app_bnb.dart';
import '../../presentation/view/home/category_screen.dart';
import '../../presentation/view/home/order_custom_service_screen.dart';
import '../../presentation/view/home/service_details_screen.dart';
import '../../presentation/view/home/service_info_screen.dart';
import '../../presentation/view/onBoarding/onboarding.dart';
import '../../presentation/view/profile/addresses_management.dart';
import '../../presentation/view/profile/become_service_provider_application_screen.dart';
import '../../presentation/view/profile/become_service_provider_info_screen.dart';
import '../../presentation/view/search/result_search.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.onBoardingRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OnBoardingCubit(),
                  child: const OnBoardingScreen(),
                ));

      case RouteConstants.signupRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AuthCubit>(
                  create: (context) => AuthCubit(),
                  child: SigUpView(),
                ));

      case RouteConstants.loginRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: const LoginView(),
                ));

      case RouteConstants.restorePasswordRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: const RestorePasswordView(),
                ));

      case RouteConstants.newPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: NewPasswordView(token: settings.arguments as String),
                ));

      case RouteConstants.emailVerificationRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: EmailVerificationView(
                      email: settings.arguments as String),
                ));
      case RouteConstants.emailConfirmationRoute:
        return MaterialPageRoute(builder: (_) => const EmailConfirmationView());
      case RouteConstants.categoryRoute:
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      case RouteConstants.serviceDetailsRoute:
        return MaterialPageRoute(builder: (_) => const ServiceDetailsScreen());
      case RouteConstants.serviceInfoRoute:
        return MaterialPageRoute(
            builder: (_) => ServiceInfoScreen(
                  isCustomService: settings.arguments as bool?,
                ));
      case RouteConstants.orderCustomServiceRoute:
        return MaterialPageRoute(
            builder: (_) => const OrderCustomServiceScreen());
      case RouteConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => const AppBNB());
      case RouteConstants.emailOtpRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AuthCubit>(
                  create: (context) => AuthCubit(),
                  child: EmailOtpScreen(
                    email: settings.arguments as String,
                  ),
                ));

      case RouteConstants.becomeServiceProviderInfoScreen:
        return MaterialPageRoute(
            builder: (_) => const BecomeServiceProviderInfoScreen());
      case RouteConstants.becomeServiceProviderApplicationScreen:
        return MaterialPageRoute(
            builder: (_) => const BecomeServiceProviderApplicationScreen());

      case RouteConstants.addressesManagementScreen:
        return MaterialPageRoute(
            builder: (_) => const AddressesManagementScreen());

      case RouteConstants.searchResultScreen:
        return MaterialPageRoute(builder: (_) => const SearchResult());
      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() => MaterialPageRoute(
      builder: (_) => const Scaffold(
            body: Text("AppStrings.noRouteFound"),
          ));
}
