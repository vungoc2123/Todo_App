import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/routes/route_name.dart';
import 'package:todo/presentation/screens/login/cubit/login_cubit.dart';
import 'package:todo/presentation/screens/login/cubit/login_state.dart';
import 'package:todo/presentation/screens/login/widget/button_login_widget.dart';

import '../home_tab/home_tab.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginCubit cubit;
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<LoginCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (_debounce?.isActive ?? false) _debounce!.cancel();
        _debounce = Timer(const Duration(milliseconds: 1000), () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.homeTab,
            arguments: const HomeTabArguments(index: 0),
            (route) => false,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoadStatus.success) {
            Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.homeTab,
                arguments: const HomeTabArguments(index: 0),
                (route) => false);
          }
        },
        child: SafeArea(
            child: Column(
          children: [
            // banner
            Expanded(
                flex: 2,
                child: Image.asset(
                  Assets.images.planning.path,
                  width: 1.sw - 32,
                  height: 1.sw,
                )),
            // button login
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  children: [
                    ButtonLoginWidget(
                        nameButton: tr("loginApple"),
                        icon:
                            Assets.icons.apple.svg(width: 20.w, height: 20.w)),
                    SizedBox(
                      height: 8.h,
                    ),
                    ButtonLoginWidget(
                      nameButton: tr("loginGoogle"),
                      icon: Image.asset(Assets.icons.google.path, width: 20.w, height: 20.w,),
                      action: () => cubit.signInWithGoogle(),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    ButtonLoginWidget(
                        nameButton: tr("loginEmail"),
                        icon: Image.asset(Assets.icons.gmail.path, width: 20.w, height: 20.w,)),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
