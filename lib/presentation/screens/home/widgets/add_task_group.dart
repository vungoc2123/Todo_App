import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/application/extensions/color_extension.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_button.dart';
import 'package:todo/presentation/common_widgets/app_label_text_field.dart';
import 'package:todo/presentation/common_widgets/app_loading.dart';
import 'package:todo/presentation/common_widgets/app_toast.dart';
import 'package:todo/presentation/screens/home/bloc/task_group_cubit.dart';
import 'package:todo/presentation/screens/home/bloc/task_group_state.dart';

class AddTaskGroup extends StatefulWidget {
  const AddTaskGroup({super.key});

  @override
  State<AddTaskGroup> createState() => _AddTaskGroupState();
}

class _AddTaskGroupState extends State<AddTaskGroup> {
  late final TaskGroupCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TaskGroupCubit>(context);
    cubit.change(icon: listIcon[0], color: listColor[0].colorToHexWithAlpha());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.gray,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        padding: EdgeInsets.all(16.r),
        child: BlocConsumer<TaskGroupCubit, TaskGroupState>(
          listener: (BuildContext context, TaskGroupState state) {
            if (LoadStatus.loading == state.status) {
              showDialog(
                  context: context,
                  builder: (context) => const AppLoading(),
                  barrierDismissible: false);
            }
            if (LoadStatus.success == state.status) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              AppToast.showToastSuccess(context, title: tr('success'));
            }
          },
          buildWhen: (previous, current) =>
              previous.taskGroupResponse != current.taskGroupResponse,
          listenWhen: (previous, current) =>
              previous.status != current.status,
          builder: (BuildContext context, state) {
            return Column(
              children: [
                Text(
                  tr("addTaskGroup"),
                  style: AppTextStyle.textXl,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomLabelTextField(
                  label: tr("nameTaskGroup"),
                  backgroundColor: AppColors.white,
                  textStyleLabel: AppTextStyle.textBase,
                  onChanged: (value) {
                    cubit.change(title: value);
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(tr("chooseColor")),
                    colorWidget(state.taskGroupResponse.color),
                    SizedBox(
                      height: 16.h,
                    ),
                    title(tr("chooseIcon")),
                    iconWidget(state.taskGroupResponse.icon),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                AppButton(
                  title: tr("add"),
                  color: AppColors.blue,
                  radius: 8.r,
                  textStyle:
                      AppTextStyle.textBase.copyWith(color: AppColors.white),
                  onPressed: () {
                    cubit.addTaskGroup();
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget title(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: AppTextStyle.textBase,
      ),
    );
  }

  Widget colorWidget(String color) {
    return SizedBox(
      width: 1.sw,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(
                listColor.length,
                (index) => InkWell(
                      onTap: () {
                        cubit.change(
                            color: listColor[index].colorToHexWithAlpha());
                      },
                      child: Container(
                          width: 30.r,
                          height: 30.r,
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: listColor[index],
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: listColor[index].colorToHexWithAlpha() == color
                              ? Assets.icons.check.svg(
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.white, BlendMode.srcIn))
                              : null),
                    )),
          ]),
    );
  }

  Widget iconWidget(String icon) {
    return SizedBox(
      width: 1.sw,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(
                listIcon.length,
                (index) => InkWell(
                      onTap: () {
                        cubit.change(icon: listIcon[index]);
                      },
                      child: SizedBox(
                          width: 25.r,
                          height: 25.r,
                          child: SvgPicture.asset(
                            listIcon[index],
                            colorFilter: ColorFilter.mode(
                                listIcon[index] == icon
                                    ? AppColors.blue
                                    : AppColors.grey,
                                BlendMode.srcIn),
                          )),
                    )),
          ]),
    );
  }
}
