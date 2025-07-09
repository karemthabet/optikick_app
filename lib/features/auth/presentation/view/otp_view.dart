import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/routes/routes.dart';
import 'package:optikick/core/widgets/custom_gradient_button.dart';
import 'package:optikick/core/widgets/gradient_background.dart';
import 'package:optikick/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifyOTPSuccess) {
          Navigator.pushNamed(context, RoutesName.newPasswordView);
        } else if (state is VerifyOTPFailure) {
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
                      'Enter the code',
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
                        'Enter the 6-digit verification code to confirm that you received.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    PinCodeTextField(
                      controller:
                          BlocProvider.of<AuthCubit>(context).verificationOTP,
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(17.r),
                        fieldHeight: 56,
                        fieldWidth: 56,
                        activeFillColor: Colors.white,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedColor: Colors.white,
                        selectedFillColor: Colors.white,
                        activeBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        selectedBorderWidth: 1,
                      ),
                      textStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    state is VerifyOTPLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 97, 103, 87),
                            ),
                          )
                        : CustomGradientButton(
                            title: 'Verify',
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context).verifyOTP();
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
