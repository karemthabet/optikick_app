import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/constants/assets.dart';
import 'package:optikick/core/routes/routes.dart';
import 'package:optikick/core/widgets/custom_gradient_button.dart';
import 'package:optikick/core/widgets/gradient_background.dart';
import 'package:optikick/core/widgets/custom_text_field.dart';
import 'package:optikick/features/auth/presentation/cubit/auth_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogInSuccess) {
          Navigator.pushNamed(context, RoutesName.bottomNavView);
        } else if (state is LogInFailure) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: state.errMessage,
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: GradientBackground(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          Assets.imagesLogoTest,
                          height: 150.h,
                          width: 110.w,
                        ),
                      ),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: 300.h,
                        child: Text(
                          'Discover Limitless Choices and Unmatched Convenience ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/Security Pass.png'),
                            Expanded(
                              child: CustomTextField(
                                controller: BlocProvider.of<AuthCubit>(context)
                                    .logInEmailField,
                                hint: 'ID',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/Password.png'),
                            Expanded(
                              child: CustomTextField(
                                controller: BlocProvider.of<AuthCubit>(context)
                                    .logInPasswordField,
                                hint: 'Password',
                                isPassword: true,
                                icon: Icons.visibility_off,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30.h,
                            child: Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                              activeColor: Color.fromARGB(255, 98, 163, 163),
                              checkColor: Colors.white,
                              side: BorderSide(color: Colors.white),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Expanded(
                              child: Text(
                            'Remember me',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      state is LogInLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 97, 103, 87),
                              ),
                            )
                          : CustomGradientButton(
                              title: 'sign in',
                              onTap: () {
                                BlocProvider.of<AuthCubit>(context).login();
                              },
                            ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.forgetPasswordView,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 13.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
