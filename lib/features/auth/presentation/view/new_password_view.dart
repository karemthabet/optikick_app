import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/routes/routes.dart';
import 'package:optikick/core/widgets/custom_gradient_button.dart';
import 'package:optikick/core/widgets/gradient_background.dart';
import 'package:optikick/core/widgets/custom_text_field.dart';
import 'package:optikick/features/auth/presentation/cubit/auth_cubit.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Success',
            desc: state.successMessage,
            btnOkOnPress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.login,
                (route) => false,
              );
            },
          ).show();
        } else if (state is ResetPasswordFailure) {
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
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close,
                              color: Colors.white, size: 30),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Enter Your New  Password',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: 350.h,
                        child: Text(
                          'Don’t worry sometimes people can forget too, enter your new password and make it easy for you to remember.',
                          style: TextStyle(
                            fontSize: 12.sp,
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
                            Image.asset('assets/images/Password.png'),
                            Expanded(
                              child: CustomTextField(
                                controller: BlocProvider.of<AuthCubit>(context)
                                    .newPasswordField,
                                hint: 'Enter Your New Password',
                                isPassword: true,
                                icon: Icons.visibility_off,
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
                                    .confirmNewPasswordField,
                                hint: 'Rewrite Your New Password',
                                isPassword: true,
                                icon: Icons.visibility_off,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      state is ResetPasswordLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 97, 103, 87),
                              ),
                            )
                          : CustomGradientButton(
                              title: 'Submit',
                              onTap: () {
                                BlocProvider.of<AuthCubit>(context)
                                    .resetPassword();
                              },
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
