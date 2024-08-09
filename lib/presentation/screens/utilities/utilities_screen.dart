import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/domain/models/arguments/update_user_arguments.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:todo/presentation/common_widgets/app_network_image.dart';
import 'package:todo/presentation/routes/route_name.dart';
import 'package:todo/presentation/screens/utilities/bloc/utilities_cubit.dart';
import 'package:todo/presentation/screens/utilities/bloc/utilities_state.dart';
import 'package:todo/presentation/screens/utilities/widget/item_widget.dart';

import '../../../application/constants/app_colors.dart';
import '../../../application/utils/navigation_utils.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({super.key});

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> with RouteAware {
  late UtilitiesCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<UtilitiesCubit>(context);
    cubit.getInfoUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NavigatorUtils.navigatorObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    super.dispose();
    NavigatorUtils.navigatorObserver.unsubscribe(this);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    cubit.getInfoUser();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;
    final locale = context.locale;

    return Scaffold(
      backgroundColor: AppColors.grayF3,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: currentTheme.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: currentTheme.primaryColor,
        title: Text(
          tr("utilities"),
          style: AppTextStyle.textXl
              .copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              BlocBuilder<UtilitiesCubit, UtilitiesState>(
                builder: (context, state) => GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, RouteName.updateUser,
                      arguments: UserArguments(
                          photoUrl: state.url,
                          userName: state.userName,
                          email: state.email)),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Row(
                      children: [
                        Container(
                          width: 1.sw / 6,
                          height: 1.sw / 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(99.r),
                              border: Border.all(
                                  color: currentTheme.primaryColor,
                                  width: 1.5)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(99.r),
                              child: AppNetworkImage(
                                state.url,
                                fit: BoxFit.fill,
                              )),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.userName,
                              style: AppTextStyle.textSm
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              state.email,
                              style: AppTextStyle.textXs.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // item utilities
              SizedBox(
                height: 16.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r)),
                child: Column(
                  children: [
                    ItemFunction(
                      actionIcon: Assets.icons.iconLanguage.svg(
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                              currentTheme.primaryColor, BlendMode.srcIn)),
                      titleAction: tr("language"),
                      color: AppColors.textPrimary,
                      action: () {
                        AppBottomSheet.showBottomSheet(context,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                  tr("choseLanguage"),
                                  style: AppTextStyle.textBase
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: InkWell(
                                          onTap: () {
                                            context.setLocale(
                                                const Locale('en', 'US'));
                                            Navigator.of(context).pop();
                                          },
                                          child: Row(children: [
                                            locale == const Locale('en', 'US')
                                                ? Icon(
                                                    Icons.done,
                                                    color: currentTheme
                                                        .primaryColor,
                                                  )
                                                : SizedBox(
                                                    width: 16.w,
                                                  ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              tr("english"),
                                              style: AppTextStyle.textSm,
                                            ),
                                          ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: InkWell(
                                          onTap: () {
                                            context.setLocale(
                                                const Locale('vi', 'VN'));
                                            Navigator.of(context).pop();
                                          },
                                          child: Row(children: [
                                            locale == const Locale('vi', 'VN')
                                                ? Icon(
                                                    Icons.done,
                                                    color: currentTheme
                                                        .primaryColor,
                                                  )
                                                : SizedBox(
                                                    width: 16.w,
                                                  ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              tr("vietnamese"),
                                              style: AppTextStyle.textSm,
                                            ),
                                          ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 32.h,
                                ),
                              ],
                            ));
                      },
                    ),
                    ItemFunction(
                      actionIcon: Assets.icons.customizeComputer.svg(
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                              currentTheme.primaryColor, BlendMode.srcIn)),
                      titleAction: tr("appearance"),
                      color: AppColors.textPrimary,
                      action: () {
                        Navigator.of(context)
                            .pushNamed(RouteName.settingGeneral);
                      },
                    ),
                    ItemFunction(
                        actionIcon: Assets.icons.musicAlt.svg(
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                                currentTheme.primaryColor, BlendMode.srcIn)),
                        titleAction: tr("sound&notify"),
                        color: AppColors.textPrimary),
                    ItemFunction(
                        actionIcon: Assets.icons.clockThree.svg(
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                                currentTheme.primaryColor, BlendMode.srcIn)),
                        titleAction: tr("date&time"),
                        color: AppColors.textPrimary),
                    ItemFunction(
                        actionIcon: Image.asset(
                          Assets.images.adjustment.path,
                          width: 20.w,
                          height: 20.w,
                          color: currentTheme.primaryColor,
                        ),
                        titleAction: tr("general"),
                        color: AppColors.textPrimary),
                  ],
                ),
              ),
              // logout
              SizedBox(
                height: 16.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r)),
                child: ItemFunction(
                  actionIcon: Assets.icons.signOutAlt.svg(
                      width: 20.w,
                      height: 20.w,
                      colorFilter: const ColorFilter.mode(
                          AppColors.red, BlendMode.srcIn)),
                  titleAction: tr("logout"),
                  color: AppColors.red,
                  isLeading: false,
                  action: () async {
                    await cubit.logout();
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteName.login, (route) => false);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
