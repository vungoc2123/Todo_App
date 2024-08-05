import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_loading.dart';
import 'package:todo/presentation/screens/signup/bloc/signup_cubit.dart';
import 'package:todo/presentation/screens/signup/bloc/signup_state.dart';

import '../../../application/constants/app_colors.dart';
import '../../../application/constants/app_text_style.dart';
import '../../common_widgets/app_label_text_field.dart';
import '../../common_widgets/app_toast.dart';
import '../../routes/route_name.dart';
import '../home_tab/home_tab.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpCubit cubit;
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<SignUpCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.colorPrimary,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: BlocListener<SignUpCubit, SignUpState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) => {
              if (state.status == LoadStatus.success)
                {
                  showDialog(
                    context: context,
                    builder: (context) => const AppLoading(),
                  ),
                  if (_debounce?.isActive ?? false) _debounce!.cancel(),
                  _debounce = Timer(const Duration(milliseconds: 1500), () {
                    AppToast.showToastSuccess(context,
                        title: "Register successfully");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteName.homeTab,
                      arguments: const HomeTabArguments(index: 0),
                      (route) => false,
                    );
                  })
                },
            },
            child: Column(
              children: [
                // title
                Column(
                  children: [
                    Text(
                      tr("signup"),
                      style: AppTextStyle.text3Xl.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      tr("subtitle signup"),
                      style: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                // text field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlocBuilder<SignUpCubit, SignUpState>(
                      buildWhen: (previous, current) =>
                          previous.errorUserName != current.errorUserName,
                      builder: (context, state) => CustomLabelTextField(
                        label: tr("userName"),
                        errorMessage: state.errorUserName,
                        onChanged: (values) => cubit.changeUserName(values),
                      ),
                    ),
                    BlocBuilder<SignUpCubit, SignUpState>(
                      buildWhen: (previous, current) =>
                          previous.errorPassword != current.errorPassword ||
                          previous.showPass != current.showPass,
                      builder: (context, state) => CustomLabelTextField(
                        label: tr("pass"),
                        obscureText: !state.showPass,
                        errorMessage: state.errorPassword,
                        onChanged: (values) => cubit.changePassword(values),
                        suffixIcon: GestureDetector(
                          onTap: () => cubit.isShowPass(),
                          child: state.showPass
                              ? Assets.icons.eye.svg()
                              : Assets.icons.eyeCrossed.svg(),
                        ),
                      ),
                    ),
                    BlocBuilder<SignUpCubit, SignUpState>(
                      buildWhen: (previous, current) =>
                          previous.errorConfirm != current.errorConfirm ||
                          previous.showConfirmPass != current.showConfirmPass,
                      builder: (context, state) => CustomLabelTextField(
                        label: tr("confirmPass"),
                        obscureText: !state.showConfirmPass,
                        errorMessage: state.errorConfirm,
                        onChanged: (values) =>
                            cubit.changeConfirmPassword(values),
                        suffixIcon: GestureDetector(
                          onTap: () => cubit.isShowConfirmPass(),
                          child: state.showConfirmPass
                              ? Assets.icons.eye.svg()
                              : Assets.icons.eyeCrossed.svg(),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 48.h,
                ),
                // button login
                BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) => InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    splashColor: AppColors.grey1.withOpacity(0.1),
                    highlightColor: AppColors.grey1.withOpacity(0.2),
                    onTap: () => cubit.signUpWithEmail(),
                    child: Ink(
                      width: 1.sw,
                      height: 52.h,
                      decoration: BoxDecoration(
                          color: AppColors.colorPrimary,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Center(
                        child: Text(
                          tr("signup"),
                          style: AppTextStyle.textLg.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
