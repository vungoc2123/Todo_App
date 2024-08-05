import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/configs/icon_loading_config.dart';
import 'package:todo/application/configs/theme_config.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_icon_loading.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/constants/app_theme.dart';
import 'package:todo/application/utils/navigation_utils.dart';
import 'package:todo/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:todo/presentation/screens/setting_general/widgets/icon_loading_widget.dart';
import 'package:todo/presentation/screens/setting_general/widgets/theme_widget.dart';

class SettingGeneralScreen extends StatefulWidget {
  const SettingGeneralScreen({super.key});

  @override
  State<SettingGeneralScreen> createState() => _SettingGeneralScreenState();
}

class _SettingGeneralScreenState extends State<SettingGeneralScreen> {
  late ValueNotifier<AppIconLoadingModel> iconLoading;

  @override
  void initState() {
    super.initState();
    iconLoading = ValueNotifier<AppIconLoadingModel>(
        IconLoadingConfig.currentIconLoading);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;
    final locale = context.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("settingGeneral"),
          style: AppTextStyle.textBase
              .copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
        ),
        centerTitle: true,
        foregroundColor: AppColors.white,
        backgroundColor: currentTheme.primaryColor,
      ),
      backgroundColor: AppColors.gray,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r)),
              child: InkWell(
                onTap: () {
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
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .setLocale(const Locale('en', 'US'));
                                      // NavigatorUtils
                                      //     .navigatorKey.currentContext!
                                      //     .setLocale(const Locale('en', 'US'));
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      tr("english"),
                                      style: AppTextStyle.textSm,
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 20.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .setLocale(const Locale('vi', 'VN'));
                                      // NavigatorUtils
                                      //     .navigatorKey.currentState!.context
                                      //     .setLocale(const Locale('vi', 'VN'));
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      tr("vietnamese"),
                                      style: AppTextStyle.textSm,
                                    ),
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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("language"),
                        style: AppTextStyle.textBase
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        locale.languageCode == 'en'
                            ? tr("english")
                            : tr("vietnamese"),
                        style: AppTextStyle.textSm
                            .copyWith(fontWeight: FontWeight.w200),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          tr("theme"),
                          style: AppTextStyle.textBase
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                    Wrap(
                      spacing: 12.r,
                      runSpacing: 12.r,
                      children: List.generate(
                          MyAppTheme.themes.length,
                          (index) => InkWell(
                                onTap: () async {
                                  AdaptiveTheme.of(context).setTheme(
                                      light:
                                          MyAppTheme.themes[index].themeData);
                                  await ThemeConfig.setCurrentTheme(
                                      MyAppTheme.themes[index]);
                                },
                                child: ThemeWidget(
                                    appTheme: MyAppTheme.themes[index],
                                    isChosen: currentTheme ==
                                        MyAppTheme.themes[index].themeData),
                              )),
                    ),
                  ]),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          tr("loading"),
                          style: AppTextStyle.textBase
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                    ValueListenableBuilder(
                      valueListenable: iconLoading,
                      builder: (context, value, _) {
                        return Wrap(
                          spacing: 12.r,
                          runSpacing: 12.r,
                          children: List.generate(
                              MyAppIconLoading.appIconLoadings.length,
                              (index) => InkWell(
                                    onTap: () async {
                                      iconLoading.value = MyAppIconLoading
                                          .appIconLoadings[index];
                                      await IconLoadingConfig
                                          .setCurrentIconLoading(
                                              MyAppIconLoading
                                                  .appIconLoadings[index]);
                                      await IconLoadingConfig
                                          .getCurrentIconLoading();
                                    },
                                    child: IconLoadingWidget(
                                        pathIcon: MyAppIconLoading
                                            .appIconLoadings[index].path,
                                        isChosen: iconLoading.value.title ==
                                            MyAppIconLoading
                                                .appIconLoadings[index].title),
                                  )),
                        );
                      },
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
