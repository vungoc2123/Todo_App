import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/presentation/screens/home_tab/home_tab.dart';
import 'package:todo/presentation/screens/home_tab/widget/bottom_bar_item_widget.dart';

class BottomBarWidget extends StatefulWidget {
  final int currentIndex;
  final List<HomePageModel> listPage;
  final Function(int index) onTap;

  const BottomBarWidget({
    super.key,
    required this.currentIndex,
    required this.listPage,
    required this.onTap,
  });

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget>   with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      leftCornerRadius: 16.r,
      rightCornerRadius: 16.r,
      height: kBottomNavigationBarHeight + 10.h,
      itemCount:widget.listPage.length,
      tabBuilder: (int index, bool isActive) {
        HomePageModel pageModel = widget.listPage[index];
        return BottomBarItemWidget(item:pageModel,isSelected:isActive);
      },
      activeIndex: widget.currentIndex,
      gapLocation: GapLocation.none,
      notchSmoothness: NotchSmoothness.softEdge,
      onTap: (index) {
        widget.onTap.call(index);
      },
      elevation: 20,
      backgroundColor: Colors.white,
      scaleFactor: 0,
      shadow: Shadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, -1),
          blurRadius: 5),

    );

    //   Container(
    //   width: 1.sw,
    //   padding: EdgeInsets.only(
    //       bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 25.h : 10.h),
    //   decoration: BoxDecoration(
    //       boxShadow: const <BoxShadow>[
    //         BoxShadow(
    //             color: Colors.black,
    //             blurRadius: 10,
    //             offset: Offset(0, 10))
    //       ],
    //       color: AppColors.white,
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(16.r),
    //         topRight: Radius.circular(16.r),
    //       )),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: widget.listPage.mapIndexed((index, item) {
    //       return GestureDetector(
    //         onTap: () {
    //           widget.onTap.call(index);
    //         },
    //         behavior: HitTestBehavior.opaque,
    //         child: BottomBarItemWidget(
    //           item: item,
    //           isSelected: widget.currentIndex == index,
    //         ),
    //       );
    //     }).toList(),
    //   ),
    // );
  }
}
