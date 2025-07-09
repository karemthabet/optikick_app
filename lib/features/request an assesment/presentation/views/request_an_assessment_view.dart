import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:optikick/core/utils/colors.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/cubits/request_assesment_cubit/request_assesment_cubit.dart';

import '../cubits/request_assesment_cubit/request_assesment_state.dart';

class SubmitNewAssesmentRequest extends StatefulWidget {
  const SubmitNewAssesmentRequest({super.key});

  @override
  State<SubmitNewAssesmentRequest> createState() =>
      _SubmitNewAssesmentRequestState();
}

class _SubmitNewAssesmentRequestState extends State<SubmitNewAssesmentRequest> {
  final _formKey = GlobalKey<FormState>();
  String? selectedIssueType;
  DateTime? selectedDateTime;
  TimeOfDay? selectedTimeOfDay;
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestAssesmentCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsManager.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Request an Assessment',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child:
                BlocListener<RequestAssesmentCubit, RequestAssesmentCubitState>(
              listener: (context, state) {
                if (state is RequestAssesmentSuccess) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    title: 'Success',
                    desc: 'Assessment request created successfully',
                    btnOkOnPress: () => Navigator.pop(context),
                  ).show();
                }
                if (state is RequestAssesmentFailure) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.topSlide,
                    title: 'Error',
                    desc: state.errMessage,
                    btnOkOnPress: () {},
                  ).show();
                }
                if (state is RequestAssesmentLoading) {
                  showDialog(
                    context: context,
                    builder: (_) => Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.realGreyColor,
                      ),
                    ),
                  );
                }
              },
              child: Stack(
                children: [
                  // Background
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff102418),
                          Color.fromARGB(255, 40, 59, 52),
                          Color(0xff566761),
                        ],
                        stops: [0.0, 0.5, 0.9],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 45.h),
                          Container(
                            padding: EdgeInsets.all(24.w),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff566761),
                                  Color.fromARGB(255, 40, 59, 52),
                                  Color(0xff102418),
                                ],
                                stops: [0.0, 0.5, 0.9],
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              children: [
                                _sectionLabel("Issue Type"),
                                DropdownButtonFormField(
                                  style: TextStyle(color: Colors.white),
                                  value: selectedIssueType,
                                  decoration: _inputDecoration(null),
                                  hint: Text(
                                    "Select an issue type",
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(128),
                                    ),
                                  ),
                                  dropdownColor: Colors.black,
                                  items: ['Muscle pain', 'Injury', 'Fatigue']
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedIssueType = value;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                  validator: (value) => value == null
                                      ? 'Please select an issue type'
                                      : null,
                                ),
                                SizedBox(height: 20.h),

                                // Date Picker
                                _sectionLabel("Date"),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(Duration(days: 30)),
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        selectedDateTime = picked;
                                      });
                                    }
                                  },
                                  decoration: _inputDecoration('Pick a date'),
                                  controller: TextEditingController(
                                    text: selectedDateTime != null
                                        ? DateFormat('yyyy-MM-dd')
                                            .format(selectedDateTime!)
                                        : '',
                                  ),
                                  validator: (_) => selectedDateTime == null
                                      ? 'Please select a date'
                                      : null,
                                ),
                                SizedBox(height: 20.h),

                                // Time Picker
                                _sectionLabel("Hour"),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? picked = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        selectedTimeOfDay = picked;
                                      });
                                    }
                                  },
                                  decoration: _inputDecoration('Pick a time'),
                                  controller: TextEditingController(
                                    text: selectedTimeOfDay != null
                                        ? selectedTimeOfDay!.format(context)
                                        : '',
                                  ),
                                  validator: (_) => selectedTimeOfDay == null
                                      ? 'Please select a time'
                                      : null,
                                ),
                                SizedBox(height: 20.h),

                                // Message
                                _sectionLabel("Message"),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: messageController,
                                  maxLines: 3,
                                  decoration: _inputDecoration(
                                    'Write your message...',
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please enter a message'
                                          : null,
                                ),
                                SizedBox(height: 24.h),

                                // Submit
                                SizedBox(
                                  width: double.infinity,
                                  height: 40.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        final date = DateFormat('yyyy-MM-dd')
                                            .format(selectedDateTime!);
                                        final time =
                                            '${selectedTimeOfDay!.hour.toString().padLeft(2, '0')}:${selectedTimeOfDay!.minute.toString().padLeft(2, '0')}';

                                        final Map<String, dynamic> requestData =
                                            {
                                          "issue_type":
                                              selectedIssueType ?? "other",
                                          "message": messageController.text,
                                          "date": date,
                                          "hour": time,
                                        };

                                        BlocProvider.of<RequestAssesmentCubit>(
                                                context)
                                            .requestAssesment(
                                                data: requestData);
                                      }
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _sectionLabel(String text) {
    return Row(
      children: [
        Text(
          " $text",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String? hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.white.withAlpha(128),
        fontSize: 14.sp,
      ),
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
      ),
      filled: true,
      fillColor: const Color(0xff191E26),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.white.withAlpha(128)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Colors.white),
      ),
    );
  }
}
