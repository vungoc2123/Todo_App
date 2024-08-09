import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/application/configs/animation_focus_config.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/focus_status.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:todo/presentation/common_widgets/app_button.dart';
import 'package:todo/presentation/screens/focus/bloc/focus_cubit.dart';
import 'package:todo/presentation/screens/focus/bloc/focus_state.dart';
import 'package:todo/presentation/screens/focus/widgets/music_widget.dart';
import 'package:todo/presentation/screens/focus/widgets/time_spinner_widget.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final FocusCubit cubit;

  // late final AnimationController _animationController;
  // late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    cubit = BlocProvider.of<FocusCubit>(context);
    _controller.value = 1;
    // _animationController =
    //     AnimationController(duration: const Duration(seconds: 10), vsync: this);
    // _animation =
    //     Tween<double>(begin: 0, end: 300).animate(_animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getIcon(FocusStatus status) {
    if (status == FocusStatus.pause) return Assets.icons.play.path;
    return Assets.icons.pause.path;
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentTheme.primaryColor,
        title: Text(
          tr("focus"),
          style: AppTextStyle.textBase
              .copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FocusCubit, FocusState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (BuildContext context, state) {
          return Container(
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.status == FocusStatus.start)
                  const TimeSpinnerWidget()
                else
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular((1.sw / 2) - 32.r),
                        child: Stack(
                          children: [
                            // Positioned(
                            //   bottom: 0,
                            //   child: AnimatedBuilder(
                            //     animation: _animation,
                            //     builder: (context, child) {
                            //       return Column(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           Lottie.asset(
                            //             Assets.animationIcon.animation3,
                            //             height: 200.h
                            //             // controller: _controller,
                            //           ),
                            //           Container(
                            //             width: 1.sw - 32.r,
                            //             height: _animation.value,
                            //             decoration: const BoxDecoration(
                            //               color: AppColors.blueE7,
                            //             ),
                            //           ),
                            //         ],
                            //       );
                            //     },
                            //   ),
                            // ),
                            // Positioned(
                            //     top: 0,
                            //     bottom: 0,
                            //     left: 0,
                            //     right: 0,
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(
                            //               (1.sw / 2) - 32.r),
                            //           border: Border.all(
                            //               width: 40.r, color: AppColors.white)),
                            //     )),
                            BlocConsumer<FocusCubit, FocusState>(
                              listenWhen: (previous, current) =>
                                  previous.percentAnimation !=
                                  current.percentAnimation,
                              buildWhen: (previous, current) =>
                                  previous.percentAnimation !=
                                  current.percentAnimation,
                              listener: (context, state) {
                                _controller.value = state.percentAnimation;
                              },
                              builder: (context, state) {
                                return CircularPercentIndicator(
                                  radius: (1.sw / 2) - 32.r,
                                  lineWidth: 6.w,
                                  center: Container(
                                    margin: EdgeInsets.all(30.r),
                                    child: Lottie.asset(
                                      AnimationFocusConfig.currentAnimationPath,
                                    ),
                                  ),
                                  percent: state.percentAnimation,
                                  progressColor: currentTheme.primaryColor,
                                  backgroundColor: currentTheme.primaryColor
                                      .withOpacity(0.3),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      BlocBuilder<FocusCubit, FocusState>(
                        buildWhen: (previous, current) =>
                            previous.timeText != current.timeText,
                        builder: (context, state) {
                          return Text(
                            state.timeText,
                            style: AppTextStyle.text4Xl.copyWith(
                                fontWeight: FontWeight.w400,
                                color: currentTheme.primaryColor),
                          );
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (state.status != FocusStatus.start) ...[
                      iconButton(
                          width: 20.r,
                          height: 20.r,
                          icon: Assets.icons.musicAlt.path,
                          color: currentTheme.primaryColor,
                          onPress: () {
                            AppBottomSheet.showBottomSheet(context,
                                child: BlocProvider.value(
                                    value: cubit, child: const MusicWidget()));
                          }),
                      iconButton(
                          width: 35.r,
                          height: 35.r,
                          icon: getIcon(state.status),
                          color: currentTheme.primaryColor,
                          onPress: () {
                            cubit.pauseOrPlaying();
                          }),
                      iconButton(
                          width: 20.r,
                          height: 20.r,
                          icon: Assets.icons.stop.path,
                          color: currentTheme.primaryColor,
                          onPress: () {
                            cubit.cancel();
                          }),
                    ],
                    if (state.status == FocusStatus.start)
                      Expanded(
                        child: AppButton(
                          title: tr("start"),
                          color: currentTheme.primaryColor,
                          textStyle: AppTextStyle.textBase
                              .copyWith(color: AppColors.white),
                          radius: 8.r,
                          onPressed: () {
                            cubit.start();
                            // _animationController.forward();
                          },
                        ),
                      )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget iconButton(
      {required String icon,
      required VoidCallback onPress,
      double? width,
      double? height,
      required Color color}) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(width: 1.w, color: color)),
        child: SvgPicture.asset(
          icon,
          width: width,
          height: height,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
}
