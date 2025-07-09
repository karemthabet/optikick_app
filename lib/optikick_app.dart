import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optikick/core/api/dio_consumer.dart';
import 'package:optikick/core/routes/app_router.dart';

import 'package:flutter/material.dart';
import 'package:optikick/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:optikick/features/home/presentation/cubit/dash_board_cubit.dart';
import 'package:optikick/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:optikick/features/profile/cubit/profile_cubit.dart';
import 'core/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptikickApp extends StatelessWidget {
  const OptikickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(api: DioConsumer(dio: Dio())),
          ),
          BlocProvider(
            create: (context) => DashBoardCubit(api: DioConsumer(dio: Dio())),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(api: DioConsumer(dio: Dio())),
          ),
          BlocProvider(
            create: (context) =>
                NotificationsCubit(api: DioConsumer(dio: Dio())),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesName.splash,
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          onGenerateRoute: AppRouter.generate,
        ),
      ),
    );
  }
}
