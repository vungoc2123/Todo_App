import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/presentation/common_widgets/app_label_text_field.dart';
import 'package:todo/presentation/common_widgets/app_loading.dart';
import 'package:todo/presentation/common_widgets/app_toast.dart';
import 'package:todo/presentation/routes/route_name.dart';
import 'package:todo/presentation/screens/home_tab/home_tab.dart';
import 'package:todo/presentation/screens/login_email/bloc/login_email_cubit.dart';
import 'package:todo/presentation/screens/login_email/bloc/login_email_state.dart';

import '../../../gen/assets.gen.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  late LoginEmailCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<LoginEmailCubit>(context);
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
      body: BlocListener<LoginEmailCubit, LoginEmailState>(
        listener: (context, state) => {
          if (state.status == LoadStatus.success)
            {
              if (Navigator.canPop(context)) {Navigator.pop(context)},
              AppToast.showToastSuccess(context, title: state.messenger ?? ''),
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteName.homeTab,
                  arguments: const HomeTabArguments(index: 0),
                  (route) => false)
            },
          if (state.status == LoadStatus.failure)
            {
              if (Navigator.canPop(context)) {Navigator.pop(context)},
              AppToast.showToastError(context, title: state.messenger ?? ''),
            },
          if (state.status == LoadStatus.loading)
            {
              showDialog(
                  context: context, builder: (context) => const AppLoading()),
              Future.delayed(const Duration(seconds: 15), () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                AppToast.showToastError(context, title: 'Lỗi kết nối');
              })
            }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                // title
                Column(
                  children: [
                    Text(
                      "Sign in",
                      style: AppTextStyle.text3Xl.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Please login to your account",
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
                    BlocBuilder<LoginEmailCubit, LoginEmailState>(
                        builder: (context, state) => CustomLabelTextField(
                              label: "UserName",
                              onChanged: (values) =>
                                  cubit.changeUserName(values),
                              errorMessage: state.errorUserName,
                            )),
                    BlocBuilder<LoginEmailCubit, LoginEmailState>(
                      builder: (context, state) => CustomLabelTextField(
                        label: "Password",
                        onChanged: (values) => cubit.changePass(values),
                        obscureText: state.isShowPass,
                        errorMessage: state.errorPassword,
                        suffixIcon: GestureDetector(
                          onTap: () => cubit.isShowPass(),
                          child: state.isShowPass
                              ? Assets.icons.eye.svg()
                              : Assets.icons.eyeCrossed.svg(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    GestureDetector(
                        onTap: () => {},
                        child: Text(
                          "Forgot Password",
                          style: AppTextStyle.textSm.copyWith(
                            color: AppColors.blueLink,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 48.h,
                ),
                // button login
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  splashColor: AppColors.grey1.withOpacity(0.1),
                  highlightColor: AppColors.grey1.withOpacity(0.2),
                  onTap: () => {
                    cubit.loginWithGmail(),
                  },
                  child: Ink(
                    width: 1.sw,
                    height: 52.h,
                    decoration: BoxDecoration(
                        color: AppColors.colorPrimary,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Center(
                      child: Text(
                        'Sign in',
                        style: AppTextStyle.textLg.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                // footer
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have account yet? ",
                      style: AppTextStyle.textSm
                          .copyWith(color: AppColors.textPrimary),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Sign up",
                          style: AppTextStyle.textSm
                              .copyWith(color: AppColors.blueLink),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, RouteName.signup);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
