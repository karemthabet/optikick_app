import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/routes/routes.dart';
import 'package:optikick/core/widgets/custom_gradient_button.dart';
import 'package:optikick/core/widgets/gradient_background.dart';
import 'package:optikick/core/widgets/custom_text_field.dart';
import 'package:optikick/features/auth/presentation/cubit/auth_cubit.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          Navigator.pushNamed(
            context,
            RoutesName.resetEmailView,
            arguments: state.forgetPassModel,
          );
        } else if (state is ForgetPasswordFailure) {
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
                    Text(
                      'Forget Password',
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
                        'Don’t worry sometimes people can forget too, enter your email and we will send you a password reset link.',
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
                          Image.asset('assets/images/Sent.png'),
                          Expanded(
                            child: CustomTextField(
                              controller: BlocProvider.of<AuthCubit>(context)
                                  .forgotPasswordEmailField,
                              hint: 'E-mail',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    state is ForgetPasswordLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 97, 103, 87),
                            ),
                          )
                        : CustomGradientButton(
                            title: 'submit',
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context)
                                  .forgetPassword();
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
