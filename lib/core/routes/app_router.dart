import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optikick/core/api/dio_consumer.dart';
import 'package:optikick/core/models/forget_pass_model.dart';
import 'package:optikick/features/auth/presentation/view/forget_password_view.dart';
import 'package:optikick/features/auth/presentation/view/login.dart';
import 'package:optikick/features/auth/presentation/view/new_password_view.dart';
import 'package:optikick/features/auth/presentation/view/otp_view.dart';
import 'package:optikick/features/auth/presentation/view/reset_email_view.dart';
import 'package:optikick/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:optikick/features/bottom_nav/presentation/views/bottom_nav_view.dart';
import 'package:optikick/features/chat/presentation/view/chat_view.dart';
import 'package:optikick/features/home/presentation/pages/home_page.dart';
import 'package:optikick/features/on_boarding/presentation/view/onboarding.dart';
import 'package:optikick/features/player/views/player_view.dart';
import 'package:optikick/features/profile/presentation/view/profile_view.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/views/request_an_assessment_view.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/views/assesment_view.dart';
import 'package:optikick/features/splash/presentation/view/splash_view.dart';
import 'package:optikick/features/stats/presentation/view/player_stats.dart';
import 'package:optikick/features/stats/presentation/view/stats_view.dart';
import 'package:optikick/features/training_program/presentation/view/traning_program_view.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.splash:
        return _buildRoute(SplashView());
      case RoutesName.onBoarding:
        return _buildRoute(OnboardingView());
      case RoutesName.login:
        return _buildRoute(const LoginView());
      case RoutesName.home:
        return _buildRoute(HomePage());
      case RoutesName.profile:
        return _buildRoute(ProfileView());
      case RoutesName.stats:
        return _buildRoute(StatsView(
          api: DioConsumer(dio: Dio()),
        ));

      case RoutesName.trainingProgram:
        return _buildRoute(
          TraningProgramView(
            api: DioConsumer(dio: Dio()),
          ),
        );

      case RoutesName.forgetPasswordView:
        return _buildRoute(ForgetPasswordView());
      case RoutesName.resetEmailView:
        final args = settings?.arguments;
        if (args is ForgetPassModel) {
          return _buildRoute(ResetEmailView(arguments: args));
        } else {
          return _buildRoute(
            const Scaffold(
              body: Center(child: Text("Something wrong, try again!")),
            ),
          );
        }
      case RoutesName.newPasswordView:
        return _buildRoute(NewPasswordView());
      case RoutesName.chatView:
        return _buildRoute(ChatView(
          userName: 'Chat',
        ));

      case RoutesName.playerStats:
        return _buildRoute(
          PlayerStats(
            playerName: 'Stats',
            api: DioConsumer(dio: Dio()),
          ),
        );

      case RoutesName.submitNewAssesmentRequest:
        return _buildRoute(SubmitNewAssesmentRequest());
      case RoutesName.viewAllAssessmentRequests:
        return _buildRoute(AssesmentView());

      case RoutesName.playerView:
        return _buildRoute(PlayerView(
          api: DioConsumer(dio: Dio()),
        ));
      case RoutesName.otpView:
        return _buildRoute(const OTPView());

      case RoutesName.bottomNavView:
        return _buildRoute(
          BlocProvider(
            create: (context) => BottomNavCubit(),
            child: const BottomNavView(),
          ),
        );
      default:
        return _buildRoute(
          const Scaffold(
            body: Center(
              child: Text('No route defined for ${RoutesName.splash}'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
