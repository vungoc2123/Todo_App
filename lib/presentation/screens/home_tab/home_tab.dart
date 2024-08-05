import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/screens/home_tab/widget/bottom_bar_widget.dart';
import 'package:todo/presentation/screens/schedule/schedules_screen.dart';
import 'package:todo/presentation/screens/update_user/update_user_screen.dart';

import '../schedule/schedule_cubit.dart';
import '../utilities/bloc/utilities_cubit.dart';
import '../utilities/utilities_screen.dart';

class HomePageModel {
  final String name;
  final String iconUrl;
  final Widget child;

  const HomePageModel({
    required this.name,
    required this.iconUrl,
    required this.child,
  });
}

class HomeTabArguments {
  final int index;

  const HomeTabArguments({required this.index});
}

class HomeTab extends StatefulWidget {
  final HomeTabArguments arguments;

  const HomeTab({super.key, required this.arguments});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late PageController controller;
  late ValueNotifier<int> currentIndex;

  final List<HomePageModel> listPages = [
    HomePageModel(
      name: tr("home"),
      iconUrl: Assets.icons.home.path,
      child: Container(),
    ),
    HomePageModel(
      name: tr("schedule"),
      iconUrl: Assets.icons.building.path,
      child: BlocProvider(
          create: (context)=> SchedulesCubit(),
          child: const ScheduleScreen()),
    ),
    HomePageModel(
      name: tr("explore"),
      iconUrl: Assets.icons.binoculars.path,
      child: Container(),
    ),
    HomePageModel(
      name: tr("document"),
      iconUrl: Assets.icons.frame.path,
      child: BlocProvider(
        create: (context) => UtilitiesCubit(),
        child: const UtilitiesScreen(),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = ValueNotifier<int>(widget.arguments.index);
    controller = PageController(initialPage: widget.arguments.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: listPages
                .map((item) =>
                    SafeArea(top: false, bottom: false, child: item.child))
                .toList(),
          ),
        ),
      ]),
      // floatingActionButton: ValueListenableBuilder(
      //   valueListenable: currentIndex,
      //   builder: (BuildContext context, value, Widget? child) {
      //     return FloatingActionButton(
      //       backgroundColor:
      //           currentIndex.value == 2 ? AppColors.textPrimary : AppColors.white,
      //       onPressed: () {
      //         currentIndex.value = 2;
      //         controller.jumpToPage(2);
      //       },
      //       shape: const CircleBorder(),
      //       child: Assets.icons.binoculars.svg(
      //           width: currentIndex.value == 2 ? 25.r : 23.r,
      //           height: currentIndex.value == 2 ? 25.r : 23.r,
      //           colorFilter: ColorFilter.mode(
      //               currentIndex.value == 2
      //                   ? AppColors.white
      //                   : AppColors.grey,
      //               BlendMode.srcIn)),
      //     );
      //   },
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (BuildContext context, int value, Widget? child) {
            return BottomBarWidget(
              currentIndex: currentIndex.value,
              onTap: (index) {
                currentIndex.value = index;
                controller.jumpToPage(index);
              },
              listPage: listPages,
            );
          }),
    );
  }
}
